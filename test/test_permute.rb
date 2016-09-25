require 'minitest/autorun'

class Permute
  def permute(input)
    return [] unless input.size > 0
    @result = [input]

    generate_result(input, 0)

    @result
  end

  def generate_result(input, pos)
    return if pos >= input.size

    for i in (pos+1)..(input.size - 1)
      new_input = input.dup
      new_input[i], new_input[pos] = new_input[pos], new_input[i]

      if !@result.include?(new_input)
        @result += [new_input]

        (pos..(input.size-1)).each do |pos|
          generate_result(new_input, pos)
        end
      end
    end
  end
end

class Permutest < Minitest::Test
  def setup
    @permuter = Permute.new
  end

  def test_can_permute_an_array
    @permuter.permute([1])
  end

  def test_produce_empty_array_for_empty_input
    assert_equal([], @permuter.permute([]))
  end

  def test_produce_only_one_result_for_one_item_input
    assert_equal([[1]], @permuter.permute([1]))
  end

  def test_produce_only_2_results_for_2_items_input
    assert_equal([[1, 2], [2, 1]], @permuter.permute([1, 2]))
  end

  def test_produce_only_1_results_for_2_items_input_with_same_value
    assert_equal([[1, 1]], @permuter.permute([1, 1]))
  end

  def test_produce_only_1_results_for_3_items_input_with_same_value
    assert_equal([[1, 1, 1]], @permuter.permute([1, 1, 1]))
  end

  def test_produce_only_1_results_for_4_items_input_with_same_value
    assert_equal([[2, 2, 2, 2]], @permuter.permute([2, 2, 2, 2]))
  end

  def test_produce_6_results_for_3_items
    result = [
      [1,2,3],
      [2,1,3],
      [2,3,1],
      [3,2,1],
      [3,1,2],
      [1,3,2]
    ]

    actual_result = @permuter.permute([1,2,3,4])

    result.each do |c|
      assert(true, actual_result.include?(c))
    end
  end

  def test_produce_24_results_for_4_items
    assert_equal(24, @permuter.permute([1,2,3,4]).size)
  end

  def test_produce_120_results_for_5_items
    assert_equal(120, @permuter.permute([1,2,3,4,5]).size)
  end

  def test_produce_720_results_for_6_items
    assert_equal(720, @permuter.permute([1,2,3,4,5,6]).size)
  end

  def test_produce_720_results_for_7_items
    assert_equal(5040, @permuter.permute([1,2,3,4,5,6,7]).size)
  end
end
