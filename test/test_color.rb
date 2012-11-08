class TestColorClass < MicroTest::Test

  test "class method red" do
    assert MicroTest::Color.red("foo") == "\e[31mfoo\e[0m"
  end

  test "class method green" do
    assert MicroTest::Color.green("foo") == "\e[32mfoo\e[0m"
  end

  test "class method yellow" do
    assert MicroTest::Color.yellow("foo") == "\e[33mfoo\e[0m"
  end

  test "class method blue" do
    assert MicroTest::Color.blue("foo") == "\e[34mfoo\e[0m"
  end

  test "class method magenta" do
    assert MicroTest::Color.magenta("foo") == "\e[35mfoo\e[0m"
  end

  test "class method cyan" do
    assert MicroTest::Color.cyan("foo") == "\e[36mfoo\e[0m"
  end

  test "class method white" do
    assert MicroTest::Color.white("foo") == "\e[37mfoo\e[0m"
  end

end

class TestColorInstance < MicroTest::Test

  class Crayon
    include MicroTest::Color
  end

  test "instance method red" do
    assert Crayon.new.red("foo") == "\e[31mfoo\e[0m"
  end

  test "instance method green" do
    assert Crayon.new.green("foo") == "\e[32mfoo\e[0m"
  end

  test "instance method yellow" do
    assert Crayon.new.yellow("foo") == "\e[33mfoo\e[0m"
  end

  test "instance method blue" do
    assert Crayon.new.blue("foo") == "\e[34mfoo\e[0m"
  end

  test "instance method magenta" do
    assert Crayon.new.magenta("foo") == "\e[35mfoo\e[0m"
  end

  test "instance method cyan" do
    assert Crayon.new.cyan("foo") == "\e[36mfoo\e[0m"
  end

  test "instance method white" do
    assert Crayon.new.white("foo") == "\e[37mfoo\e[0m"
  end

end
