# MicroTest

[![Build Status](https://travis-ci.org/hopsoft/micro_test.png)](https://travis-ci.org/hopsoft/micro_test)
[![Dependency Status](https://gemnasium.com/hopsoft/micro_test.png)](https://gemnasium.com/hopsoft/micro_test)
[![Code Climate](https://codeclimate.com/github/hopsoft/micro_test.png)](https://codeclimate.com/github/hopsoft/micro_test)

## The Sinatra of testing frameworks

Testing frameworks often lose their focus and become an end unto themselves.
MicroTest avoids this pitfall with a relentless focus on simplicity.

[An important note](https://github.com/hopsoft/micro_test/wiki/Debug-Test-Failures-with-Pry#gemfile-considerations)
for those wanting to debug test failures with Pry.

### Here's what MicroTest brings to the table

* A simple test API/interface
* An awesome test + dev workflow using Pry
* Fast asynchronous test runs

## The Interface

Everything you need to know about MicroTest's API is outlined here.

Its simple by design.

<table>
  <tr>
    <td><strong><code>MicroTest::Test</code></strong></td>
    <td>Superclass for all test classes.</td>
  </tr>
  <tr>
    <td><strong><code>test(desc, &block)</code></strong></td>
    <td>
      Defines a test method.
      <ul>
        <li><sr<code>desc</code> - a description of what is being tested</li>
        <li><code>block</code> - a block of code which defines the test</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td><strong><code>assert(value)</code></strong></td>
    <td>
      Verifies the truthiness of a value.
      <ul>
        <li><code>value</code> - the value to assert</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td><strong><code>before(&block)</code></strong></td>
    <td>
      A callback that runs before each test method.
      <ul>
        <li><code>&block</code> - the block of code to execute</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td><strong><code>after(&block)</code></strong></td>
    <td>
      A callback that runs after each test method.
      <ul>
        <li><code>&block</code> - the block of code to execute</li>
      </ul>
    </td>
  </tr>
</table>

## A Full Example

The entire public interface is used in this basic example.

```ruby
class MathTest < MicroTest::Test

  before do
    # runs before each test method
  end

  after do
    # runs after each test method
  end

  test "basic addition" do
    assert 2 + 2 == 4
  end

end
```

## Get Started

MicroTest ships with a demo so you can kick the tires.

* Install `$ gem install micro_test`
* Help `$ mt --help`
* Demo `$ mt --demo`

Try some of the more advanced features.

* Pry workflow `$ mt --demo --pry`
* Async test run `$ mt --demo --async`

MicroTest is small & unobtrusive. It can run parallel with other test frameworks,
and can be introduced to existing projects with minimal effort.

## Advanced

[See the wiki](https://github.com/hopsoft/micro_test/wiki) to troubleshoot or dig into more advanced topics.

*Be sure to checkout [MicroMock](https://github.com/hopsoft/micro_mock) for a lightweight mocking solution.*

Start testing today!
