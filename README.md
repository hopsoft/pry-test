[![Lines of Code](http://img.shields.io/badge/loc-462-brightgreen.svg)](http://blog.codinghorror.com/the-best-code-is-no-code-at-all/)
[![Code Status](https://codeclimate.com/github/hopsoft/pry-test.png)](https://codeclimate.com/github/hopsoft/pry-test)
[![Dependency Status](https://gemnasium.com/hopsoft/pry-test.png)](https://gemnasium.com/hopsoft/pry-test)
[![Build Status](https://travis-ci.org/hopsoft/pry-test.png)](https://travis-ci.org/hopsoft/pry-test)
[![Coverage Status](https://img.shields.io/coveralls/hopsoft/pry-test.svg)](https://coveralls.io/r/hopsoft/pry-test?branch=master)

# PryTest

A testing framework that supports debugging test failures & errors when they happen.

_Formerly known as `MicroTest`._

## Benefits

* A simple test API
* An awesome `fail` `pry` `pass` workflow
* Async test runs
* Works with all major Rubies

[An important note on debugging test failures with Pry.](https://github.com/hopsoft/pry-test/wiki/Debug-Test-Failures-with-Pry#gemfile-considerations)

## The API

Everything you need to know about PryTest's API is outlined here.

<table>
  <tr>
    <td><strong><code>PryTest::Test</code></strong></td>
    <td></td>
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

### A Complete Example

The entire public interface is used in this basic example.

```ruby
class MathTest < PryTest::Test

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

PryTest ships with a demo so you can try it out easily.

```sh
gem install pry-test
pry-test --help
pry-test --demo
```

Try some advanced features.

```sh
pry-test --demo --async
pry-test --demo --disable-pry
```

## Testing Your Own Projects

PryTest assumes your test directory is located at `PROJECT_ROOT/test`;
however, this isn't a requirement. You can indicate your test directory location.

```sh
pry-test /path/to/test/dir
```

If you have multiple versions of PryTest installed,
it's safest to run your tests with `bundle exec`.

```sh
bundle exec pry-test /path/to/test/dir
```

PryTest is small & unobtrusive.
It plays nice with other test frameworks, & can be introduced to existing projects incrementally.

## Advanced

[See the wiki](https://github.com/hopsoft/pry-test/wiki)
to troubleshoot or get help with more advanced topics.
