# MicroTest

## The Sinatra of testing frameworks

Testing frameworks often lose their focus and become an end unto themselves.
MicroTest avoids this pitfall with a relentless focus on simplicity.

### Here's what MicroTest brings to the table

* A simple test API
* An awesome test + dev workflow with Pry
* Fast asynchronous test runs with Celluloid

## The Interface

Everything you need to know about MicroTest's API is outlined here.
Its simple by design.

<table>
  <tr>
    <td><strong><code>MicroTest::Test</code></strong></td>
    <td>Superclass for all test classes.</td>
  </tr>
  <tr></tr>>
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

## An Example

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

<ul>
  <li>Install - <code>$ gem install micro_test</code></li>
  <li>Help - <code>$ mt --help</code></li>
  <li>Demo - <code>$ mt --demo</code></li>
</ul>
