@api @delete_student
Feature: Delete Student
  Scenario Outline: Delete student as <role> and verify status code 403 (negative)
    Given authorization token is provided for "<role>"
    And user accepts content type as "application/json"
    When user sends DELETE request to "/api/students/5325" to exclude student
    And user verifies that response status code is 403
    And user verifies that status line contains "Forbidden"

    Examples: roles
      | role        |
      | team member |
      | team leader |

    @ignore
  Scenario: Delete student as teacher and verify status code 204 (positive)
    Given authorization token is provided for "teacher"
    And user accepts content type as "application/json"
    When user sends DELETE request to "/api/students/5325" to exclude student
    And user verifies that response status code is 204

  Scenario: Try to delete a student with incorrect id and verify that status code is 422 (negative)
    Given authorization token is provided for "teacher"
    And user accepts content type as "application/json"
    When user sends DELETE request to "/api/students/0" to exclude student
    And user verifies that response status code is 422
    And user verifies that payload contains "requested student-id resource was not found." message
