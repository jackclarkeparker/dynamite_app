# Why you don't need to test for invalid input types in Rails

In rails when a form is submitted with values for inputs that do not match the type expected for those inputs, Rails substitutes the incorrect typed values with `nil`.

A test suite should cover missing parameters - if you are doing this, then you are already testing scenarios where invalid input typed values are submitted.