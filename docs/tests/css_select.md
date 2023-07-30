# Making assertions using css_select

I wanted to include assertions in my "should fail to update tutor when missing params" test, to assert that the inputs
of the rerendered edit template what carry the values that the user had supplied (or in this case removed).
It was important to include this for regression testing purposes - there had been a scenario where the test was passing,
because the appropriate error messages were being displayed, but in actuality, the form was not being properly supplied
with the values that the user had given, due to an issue with the SCD `\_failed_edit` flow. (This is a somewhat complex work flow detailed in the SCD doc).

In order to ensure correctness of the rerendering, it was important to make assertions about the inputs being rerendered.
So I spent quite some time attempting to get assert_select to do this. What I wanted was an accurate assertion that one of the divs in the html of a `\_form` rerendered did indeed carry with it the specific label and input of the offending field that had been left blank. I rand into lots of difficulties getting this to work, and in the end opted for css_select instead. css_select returns a collection of matching elements, which allows for a more customised assertion. However, these are not stored in an actual array, and as such the #any? method doesn't work out of the box here. In the end, I instead opted for a simple solution involving iteration with #each, which does work, and setting a flag variable to true when matches are found.

I'm going to keep using this approach in the tutors_controller_test, but along the way, I did discover a simpler way of testing
this, which did involve assert_select, which I'll use in all the other controller tests instead. Rails wraps inputs that have an error associated with them in their own div, with a class `field_with_errors`. This makes it trivial to test for them with assert_select, and I sort of suspect a bit faster than iterating through each of the elements targeted with the css_select approach, which may involve more iteration, and is a bit more heavyweight, taking up more LOC. Although, it may be an idea to refactor each of these assertion styles by extracting to helper methods that are easier to read in the tests. This is not something I intend to spend time on right now though; it's time to keep moving.
