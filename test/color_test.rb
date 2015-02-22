unless ENV["PRY_TEST_DEMO"]
  require_relative "test_helper"

  class ColorTest < PryTest::Test
    class Crayon
      include PryTest::Color
    end
    CRAYON = Crayon.new

    test "default" do
      assert PryTest::Color.default("foo") == "foo"
      assert ColorTest::CRAYON.default("foo") == "foo"
    end

    test "red" do
      assert PryTest::Color.red("foo") == "\e[31mfoo\e[0m"
      assert ColorTest::CRAYON.red("foo") == "\e[31mfoo\e[0m"
    end

    test "green" do
      assert PryTest::Color.green("foo") == "\e[32mfoo\e[0m"
      assert ColorTest::CRAYON.green("foo") == "\e[32mfoo\e[0m"
    end

    test "yellow" do
      assert PryTest::Color.yellow("foo") == "\e[33mfoo\e[0m"
      assert ColorTest::CRAYON.yellow("foo") == "\e[33mfoo\e[0m"
    end

    test "blue" do
      assert PryTest::Color.blue("foo") == "\e[34mfoo\e[0m"
      assert ColorTest::CRAYON.blue("foo") == "\e[34mfoo\e[0m"
    end

    test "magenta" do
      assert PryTest::Color.magenta("foo") == "\e[35mfoo\e[0m"
      assert ColorTest::CRAYON.magenta("foo") == "\e[35mfoo\e[0m"
    end

    test "cyan" do
      assert PryTest::Color.cyan("foo") == "\e[36mfoo\e[0m"
      assert ColorTest::CRAYON.cyan("foo") == "\e[36mfoo\e[0m"
    end

    test "white" do
      assert PryTest::Color.white("foo") == "\e[37mfoo\e[0m"
      assert ColorTest::CRAYON.white("foo") == "\e[37mfoo\e[0m"
    end

    test "gray" do
      assert PryTest::Color.gray("foo") == "\e[90mfoo\e[0m"
      assert ColorTest::CRAYON.gray("foo") == "\e[90mfoo\e[0m"
    end

  end

end
