# MicroTest

#### Home of the `fail` `pry` `pass` testing workflow.

---

[![Lines of Code](http://img.shields.io/badge/loc-480-brightgreen.svg)](http://blog.codinghorror.com/the-best-code-is-no-code-at-all/)
[![Code Status](https://codeclimate.com/github/hopsoft/micro_test.png)](https://codeclimate.com/github/hopsoft/micro_test)
[![Dependency Status](https://gemnasium.com/hopsoft/micro_test.png)](https://gemnasium.com/hopsoft/micro_test)
[![Build Status](https://travis-ci.org/hopsoft/micro_test.png)](https://travis-ci.org/hopsoft/micro_test)
[![Coverage Status](https://img.shields.io/coveralls/hopsoft/micro_test.svg)](https://coveralls.io/r/hopsoft/micro_test?branch=master)

---

Save time by dropping into a Pry debug session on test failure.

> It's an awesome workflow... I only wish that I had discovered it sooner. --Thomas A. Anderson

## Benefits

* A simple test API
* An awesome `fail` `pry` `pass` workflow
* Async test runs
* Works with all major Rubies

[An important note on debugging test failures with Pry.](https://github.com/hopsoft/micro_test/wiki/Debug-Test-Failures-with-Pry#gemfile-considerations)

## The API

Everything you need to know about MicroTest's API is outlined here.

<table>
  <tr>
    <td><strong><code>MicroTest::Test</code></strong></td>
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

MicroTest ships with a demo so you can try it out easily.

```sh
gem install micro_test
mt --help
mt --demo
```

Try some advanced features.

```sh
mt --demo --pry
mt --demo --async
mt --demo --formatter doc
```

## Testing Your Own Projects

MicroTest assumes your test directory is located at `PROJECT_ROOT/test`;
however, this isn't a requirement. You can indicate your test directory location.

```sh
mt /path/to/test/dir
```

If you have multiple versions of MicroTest installed,
it's safest to run your tests with `bundle exec`.

```sh
bundle exec mt /path/to/test/dir
```

MicroTest is small & unobtrusive.
It plays nice with other test frameworks, & can be introduced to existing projects incrementally.

## Advanced

[See the wiki](https://github.com/hopsoft/micro_test/wiki)
to troubleshoot or get help with more advanced topics.

*Also, checkout [MicroMock](https://github.com/hopsoft/micro_mock) for a lightweight mocking solution.*

