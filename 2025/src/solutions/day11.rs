use std::collections::HashMap;

use crate::solution::Solution;

struct Device {
    name: String,
    outputs: Vec<String>,
}

pub struct Solver {
    devices: HashMap<String, Device>,
}

fn line_to_device(line: &str) -> Device {
    let mut split: Vec<&str> = line.split(':').collect();

    let Some(outputs) = split.pop() else {
        panic!("There are no outputs on line '{line}'!");
    };

    let Some(name) = split.pop() else {
        panic!("The device definition line '{line}' is empty!")
    };

    Device {
        name: name.to_owned(),
        outputs: outputs
            .split(' ')
            .filter(|value| !value.is_empty())
            .map(str::to_string)
            .collect(),
    }
}

fn get_path_count(devices: &HashMap<String, Device>, start_name: &str, end_name: &str) -> u32 {
    let mut valid_path_count = 0;

    let mut paths: Vec<Vec<String>> = vec![vec![start_name.to_owned()]];
    while let Some(path) = paths.pop() {
        let Some(last_device) = path
            .last()
            .and_then(|last_device_id| devices.get(last_device_id))
        else {
            panic!(
                "Could not find the requested device from {}",
                path.join(",")
            );
        };

        let viable_outputs = last_device
            .outputs
            .iter()
            .filter(|output| !path.contains(output));

        for output in viable_outputs {
            if output == end_name {
                valid_path_count += 1;
                continue;
            }

            let mut new_path = path.clone();
            new_path.push(output.to_owned());
            paths.push(new_path);
        }
    }

    valid_path_count
}

fn get_cache_key(device_name: &str, visited_dac: bool, visited_fft: bool) -> String {
    format!("{device_name}-{visited_dac}-{visited_fft}")
}

fn count_routes(
    cache: &mut HashMap<String, u64>,
    devices: &HashMap<String, Device>,
    device: &Device,
    visited_dac: bool,
    visited_fft: bool,
    end_name: &str,
) -> u64 {
    if let Some(cached_value) = cache.get(&get_cache_key(&device.name, visited_dac, visited_fft)) {
        return *cached_value;
    }

    let result = match &*device.name {
        device_name if device_name == end_name => u64::from(visited_dac && visited_fft),
        "dac" => device
            .outputs
            .iter()
            .map(|output_device_name| {
                count_routes(
                    cache,
                    devices,
                    devices
                        .get(output_device_name)
                        .expect("Could not find the output device!"),
                    true,
                    visited_fft,
                    end_name,
                )
            })
            .sum(),
        "fft" => device
            .outputs
            .iter()
            .map(|output_device_name| {
                count_routes(
                    cache,
                    devices,
                    devices
                        .get(output_device_name)
                        .expect("Could not find the output device!"),
                    visited_dac,
                    true,
                    end_name,
                )
            })
            .sum(),
        _ => device
            .outputs
            .iter()
            .map(|output_device_name| {
                count_routes(
                    cache,
                    devices,
                    devices
                        .get(output_device_name)
                        .expect("Could not find the output device!"),
                    visited_dac,
                    visited_fft,
                    end_name,
                )
            })
            .sum(),
    };

    cache.insert(
        get_cache_key(&device.name, visited_dac, visited_fft),
        result,
    );

    result
}

fn get_paths_through_dac_and_fft(
    devices: &HashMap<String, Device>,
    start_name: &str,
    end_name: &str,
) -> u64 {
    let mut cache: HashMap<String, u64> = HashMap::new();

    let Some(start_device) = devices.get(start_name) else {
        panic!("Could not find the start device '{start_name}'!");
    };

    count_routes(&mut cache, devices, start_device, false, false, end_name)
}

impl Solution for Solver {
    fn new(input: String) -> Self {
        let mut devices = input.lines().filter(|line| !line.is_empty()).fold(
            HashMap::new(),
            |mut devices, line| {
                let device = line_to_device(line);

                devices.insert(device.name.clone(), device);

                devices
            },
        );

        if !devices.contains_key("out") {
            devices.insert(
                "out".to_owned(),
                Device {
                    name: "out".to_owned(),
                    outputs: vec![],
                },
            );
        }

        Solver { devices }
    }

    fn first_stage(&self) -> String {
        get_path_count(&self.devices, "you", "out").to_string()
    }

    fn second_stage(&self) -> String {
        get_paths_through_dac_and_fft(&self.devices, "svr", "out").to_string()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_first_stage() {
        assert_eq!(
            Solver::new(
                "aaa: you hhh\n\
        you: bbb ccc\n\
        bbb: ddd eee\n\
        ccc: ddd eee fff\n\
        ddd: ggg\n\
        eee: out\n\
        fff: out\n\
        ggg: out\n\
        hhh: ccc fff iii\n\
        iii: out\n\
"
                .to_owned()
            )
            .first_stage(),
            "5"
        );
    }

    #[test]
    fn test_second_stage() {
        assert_eq!(
            Solver::new(
                "svr: aaa bbb\n\
                aaa: fft\n\
                fft: ccc\n\
                bbb: tty\n\
                tty: ccc\n\
                ccc: ddd eee\n\
                ddd: hub\n\
                hub: fff\n\
                eee: dac\n\
                dac: fff\n\
                fff: ggg hhh\n\
                ggg: out\n\
                hhh: out
"
                .to_owned()
            )
            .second_stage(),
            "2"
        );
    }
}
