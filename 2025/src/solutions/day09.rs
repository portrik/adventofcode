use itertools::Itertools;

use crate::solution::Solution;

#[derive(Clone, Copy)]
struct Point {
    x: i32,
    y: i32,
}

impl Point {
    fn new(x: i32, y: i32) -> Self {
        Point { x, y }
    }
}

impl PartialEq for Point {
    fn eq(&self, other: &Self) -> bool {
        self.x == other.x && self.y == other.y
    }
}

impl Eq for Point {}

struct Rectangle {
    corners: [Point; 4],
    area: i64,
}

impl Rectangle {
    fn new(first: Point, second: Point) -> Self {
        let area = ((i64::from(first.x) - i64::from(second.x)).abs() + 1)
            * ((i64::from(first.y) - i64::from(second.y)).abs() + 1);

        Rectangle {
            corners: [
                Point::new(first.x.min(second.x), first.y.max(second.y)),
                Point::new(first.x.max(second.x), first.y.max(second.y)),
                Point::new(first.x.min(second.x), first.y.min(second.y)),
                Point::new(first.x.max(second.x), first.y.min(second.y)),
            ],
            area,
        }
    }
}

impl Ord for Rectangle {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        self.area.cmp(&other.area)
    }
}

impl PartialOrd for Rectangle {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

impl PartialEq for Rectangle {
    fn eq(&self, other: &Self) -> bool {
        self.area == other.area
            && self
                .corners
                .iter()
                .all(|corner| other.corners.contains(corner))
    }
}

impl Eq for Rectangle {}

struct Polygon {
    vertices: Vec<Point>,
}

fn point_is_on_line(point: Point, (first, second): (Point, Point)) -> bool {
    let is_on_x =
        (point.x >= first.x && point.x <= second.x) || (point.x >= second.x && point.x <= first.x);
    let is_on_y =
        (point.y >= first.y && point.y <= second.y) || (point.y >= second.y && point.y <= first.y);

    is_on_x && is_on_y
}

/// Runs on the Wikipedia equation with some modifications from
/// <https://stackoverflow.com/a/385355>
fn do_lines_intersect(first: (Point, Point), second: (Point, Point)) -> bool {
    let first_x = f64::from(first.0.x) - f64::from(first.1.x);
    let second_x = f64::from(second.0.x) - f64::from(second.1.x);
    let first_y = f64::from(first.0.y) - f64::from(first.1.y);
    let second_y = f64::from(second.0.y) - f64::from(second.1.y);

    let closeness = first_x * second_y - first_y * second_x;
    if closeness.abs() < 0.01 {
        return false;
    }

    let a =
        f64::from(first.0.x) * f64::from(first.1.y) - f64::from(first.0.y) * f64::from(first.1.x);
    let b = f64::from(second.0.x) * f64::from(second.1.y)
        - f64::from(second.0.y) * f64::from(second.1.x);

    let intersection_x = ((a * second_x - b * first_x) / closeness).round();
    let intersection_y = ((a * second_y - b * first_y) / closeness).round();
    #[allow(clippy::cast_possible_truncation)]
    let intersection_point = Point::new(intersection_x as i32, intersection_y as i32);

    let is_on_lines =
        point_is_on_line(intersection_point, first) && point_is_on_line(intersection_point, second);
    let is_one_of_the_points = intersection_point == first.0
        || intersection_point == first.1
        || intersection_point == second.0
        || intersection_point == second.1;

    is_on_lines && !is_one_of_the_points
}

impl Polygon {
    fn new(vertices: &[Point]) -> Self {
        Polygon {
            vertices: vertices.iter().map(std::clone::Clone::clone).collect(),
        }
    }

    /// Thanks Mr Franklin <https://wrfranklin.org/Research/Short_Notes/pnpoly.html>
    fn contains_point(&self, point: Point) -> bool {
        // The point is one of the vertices
        if self.vertices.contains(&point) {
            return true;
        }

        let vertex_count = self.vertices.len();
        // The point is on one of the edges
        if self.vertices.iter().enumerate().any(|(index, first)| {
            point_is_on_line(point, (*first, self.vertices[(index + 1) % vertex_count]))
        }) {
            return true;
        }

        // Checks whether the point is inside using ray casting
        let mut inside = false;
        for position in 0..vertex_count {
            let first = self.vertices[position];
            let second = self.vertices[(position + 1) % vertex_count];

            if (point.y < first.y) == (point.y < second.y) {
                continue;
            }

            let upper = f64::from(point.y) - f64::from(first.y);
            let lower = f64::from(second.y) - f64::from(first.y);
            let x_difference = f64::from(second.x) - f64::from(first.x);

            let x_value = f64::from(first.x) + (upper / lower) * x_difference;
            if f64::from(point.x) < x_value {
                inside = !inside;
            }
        }

        inside
    }

    fn intersects_segment(&self, start: Point, end: Point) -> bool {
        self.vertices.iter().enumerate().any(|(index, first)| {
            do_lines_intersect(
                (start, end),
                (*first, self.vertices[(index + 1) % self.vertices.len()]),
            )
        })
    }

    fn contains_rectangle(&self, rectangle: &Rectangle) -> bool {
        if rectangle
            .corners
            .iter()
            .any(|point| !self.contains_point(*point))
        {
            return false;
        }

        let polygon_lines: Vec<(Point, Point)> = self
            .vertices
            .iter()
            .enumerate()
            .map(|(index, first)| (*first, self.vertices[(index + 1) % self.vertices.len()]))
            .collect();

        if (0..rectangle.corners.len())
            .map(|index| (rectangle.corners[index], rectangle.corners[(index + 1) % 4]))
            .filter(|(left, right)| {
                !polygon_lines.contains(&(*left, *right))
                    && !polygon_lines.contains(&(*right, *left))
            })
            .any(|(start, end)| self.intersects_segment(start, end))
        {
            return false;
        }

        true
    }
}

pub struct Solver {
    points: Vec<Point>,
}

fn parse_line(line: &str) -> Point {
    let values: Vec<i32> = line
        .split(',')
        .map(|value| match value.parse::<i32>() {
            Ok(value) => value,
            _ => panic!("As any Cloudflare engineer knows, {value} is not a number!"),
        })
        .collect();

    let Some(coordinates) = values[..2].first_chunk::<2>() else {
        panic!(
            "What a wonderful world of Cloudflare. There are not enough numbers for the coordinates!"
        );
    };

    Point::new(coordinates[0], coordinates[1])
}

impl Solution for Solver {
    fn new(input: String) -> Self {
        Solver {
            points: input.lines().map(parse_line).collect(),
        }
    }

    fn first_stage(&self) -> String {
        self.points
            .iter()
            .enumerate()
            .fold(0_i64, |accumulator, (index, left)| {
                self.points[index + 1..]
                    .iter()
                    .map(|right| Rectangle::new(*left, *right).area)
                    .max()
                    .unwrap_or(accumulator)
                    .max(accumulator)
            })
            .to_string()
    }

    fn second_stage(&self) -> String {
        let rectangles: Vec<Rectangle> = self
            .points
            .iter()
            .enumerate()
            .flat_map(|(index, left)| {
                self.points[index + 1..]
                    .iter()
                    .map(|right| Rectangle::new(*left, *right))
            })
            .sorted_by(|a, b| b.cmp(a))
            .collect();

        let polygon = Polygon::new(&self.points);

        let Some(rectangle) = rectangles
            .iter()
            .find(|rectangle| polygon.contains_rectangle(rectangle))
        else {
            panic!("No rectangle contained in the polygon could be found!");
        };

        rectangle.area.to_string()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_first_stage() {
        assert_eq!(
            Solver::new(
                "7,1\n\
                11,1\n\
                11,7\n\
                9,7\n\
                9,5\n\
                2,5\n\
                2,3\n\
                7,3\n\
"
                .to_owned()
            )
            .first_stage(),
            "50"
        );
    }

    #[test]
    fn test_second_stage() {
        assert_eq!(
            Solver::new(
                "7,1\n\
            11,1\n\
            11,7\n\
            9,7\n\
            9,5\n\
            2,5\n\
            2,3\n\
            7,3\n\
"
                .to_owned()
            )
            .second_stage(),
            "24"
        );
    }
}
