use crate::solution::Solution;

pub struct Solver {
    input: String,
}

impl Solution for Solver {
    fn new(input: String) -> Self {
        Solver { input }
    }

    fn first_stage(&self) -> String {
        self.input.len().to_string()
    }

    fn second_stage(&self) -> String {
        self.input.len().to_string()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_first_stage() {
        assert_eq!(Solver::new("input".to_owned()).first_stage(), "5");
    }

    #[test]
    fn test_second_stage() {
        assert_eq!(Solver::new("input".to_owned()).second_stage(), "5");
    }
}
