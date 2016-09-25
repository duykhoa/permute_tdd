require 'minitest/autorun'

class Permute
  def permute(input)
    return [] unless input.size > 0
    return [input] if input.size < 2

    input_reverse = []

    size = input.size - 1
    input.each_with_index { |item, index| input_reverse[size - index] = item }

    input_reverse == input ? [input] : [ input, input_reverse ]
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

  def test_produce_3_results_for_3_items_and_1_has_different_value
    result = [
      [1,1,2],
      [1,2,1],
      [2,1,1]
    ]

    assert_equal(result, @permuter.permute([1,1,2]))
  end
end
