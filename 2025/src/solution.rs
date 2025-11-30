pub trait Solution {
    fn new(input: String) -> Self;

    /// Solves the first stage using the input from the constructor.
    fn first_stage(&self) -> String;

    /// Solves the second stage using the input from the constructor.
    fn second_stage(&self) -> String;
}
