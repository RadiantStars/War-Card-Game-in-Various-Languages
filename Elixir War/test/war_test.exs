defmodule WarTest do
  use ExUnit.Case
  doctest War

  test "deal_1" do
    t1 = [1,1,1,1,13,13,13,13,11,11,11,11,12,12,12,12,10,10,10,10,9,9,9,9,7,7,7,7,8,8,8,8,6,6,6,6,5,5,5,5,4,4,4,4,3,3,3,3,2,2,2,2]
    r1 = [1,1,1,1,13,13,13,13,12,12,12,12,11,11,11,11,10,10,10,10,9,9,9,9,8,8,8,8,7,7,7,7,6,6,6,6,5,5,5,5,4,4,4,4,3,3,3,3,2,2,2,2]
    assert War.deal(t1) == r1
  end

  test "deal_2" do
    t2 = [1,13,1,13,1,13,1,13,12,11,12,11,12,11,12,11,10,9,10,9,10,9,10,9,8,7,8,7,8,7,8,7,6,5,6,5,6,5,6,5,4,3,4,3,4,3,4,3,2,2,2,2]
    r2 = [4,3,2,2,2,2,4,3,4,3,4,3,6,5,6,5,6,5,6,5,8,7,8,7,8,7,8,7,10,9,10,9,10,9,10,9,12,11,12,11,12,11,12,11,1,13,1,13,1,13,1,13]
    assert War.deal(t2) == r2
  end

  test "deal_3" do
    t3 = [13,1,13,1,13,1,13,1,11,12,11,12,11,12,11,12,9,10,9,10,9,10,9,10,7,8,7,8,7,8,7,8,5,6,5,6,5,6,5,6,3,4,3,4,3,4,3,4,2,2,2,2]
    r3 = [4,3,2,2,2,2,4,3,4,3,4,3,6,5,6,5,6,5,6,5,8,7,8,7,8,7,8,7,10,9,10,9,10,9,10,9,12,11,12,11,12,11,12,11,1,13,1,13,1,13,1,13]
    assert War.deal(t3) == r3
  end

  test "deal_4" do
    t4 = [10,11,12,13,1,2,3,4,5,6,7,8,9,10,11,12,13,1,2,3,4,5,6,7,8,9,10,11,12,13,1,2,3,4,5,6,7,8,9,10,11,12,13,1,2,3,4,5,6,7,8,9]
    r4 = [1,1,13,12,9,5,11,4,9,3,8,7,7,2,13,10,12,5,10,4,9,6,8,3,1,1,13,12,7,5,11,4,9,3,8,6,7,2,13,10,12,5,11,11,10,8,6,4,6,3,2,2]
    assert War.deal(t4) == r4
  end

  test "deal_5" do
    t5 = [1,2,3,4,5,6,7,8,9,10,11,12,13,1,2,3,4,5,6,7,8,9,10,11,12,13,1,2,3,4,5,6,7,8,9,10,11,12,13,1,2,3,4,5,6,7,8,9,10,11,12,13]
    r5 = [1,10,13,8,11,9,8,7,11,8,13,7,13,6,12,6,9,5,8,5,7,4,7,4,11,6,12,10,6,3,2,2,12,5,9,3,10,4,9,2,10,3,5,2,1,1,1,13,12,11,4,3]
    assert War.deal(t5) == r5
  end

  test "deal_6" do
	t6 =  [2,3,3,3,2,2,3,2,5,4,5,4,5,4,5,4,7,6,7,6,7,6,7,6,9,8,9,8,9,8,9,8,11,10,11,10,11,10,11,10,13,12,13,12,1,12,1,12,1,13,1,13]
	r6 =  [1,12,13,12,13,12,11,10,11,10,11,10,11,10,9,8,9,8,9,8,9,8,7,6,7,6,7,6,7,6,5,4,5,4,5,4,5,4,3,2,1,3,13,3,1,3,13,2,1,2,12,2]
	assert War.deal(t6) == r6
  end

  test "deal_7" do
	t7 =  [10,6,3,11,9,13,12,4,7,1,1,13,2,7,6,10,8,2,4,12,11,8,4,9,3,3,2,10,5,8,5,13,6,4,7,1,12,9,3,5,2,13,9,11,12,7,6,5,1,11,10,8]
	r7 =  [8,3,11,11,11,10,8,7,5,5,4,2,4,2,1,9,12,9,7,6,4,2,1,1,1,13,13,10,9,8,6,3,11,9,12,8,10,5,7,5,13,6,13,3,12,6,12,4,10,3,7,2]
	assert War.deal(t7) == r7
  end

  test "deal_8" do
	t8 =  [9,9,8,5,13,8,3,6,10,9,5,9,7,1,6,1,3,11,8,10,2,5,10,4,1,12,7,3,4,13,5,11,2,11,1,7,12,6,8,7,13,13,2,4,2,4,12,11,3,12,6,10]
	r8 =  [5,3,13,7,13,10,12,6,11,6,10,6,8,5,7,2,9,8,6,4,5,4,11,7,13,12,3,3,3,2,11,9,10,5,7,4,1,13,1,12,11,10,9,4,9,2,8,2,1,1,12,8]
	assert War.deal(t8) == r8
  end

  test "deal_9" do
	t9 =  [13,3,11,2,5,1,9,3,12,11,11,8,6,8,9,6,13,6,1,4,5,3,10,11,13,7,7,5,13,4,3,10,10,12,4,10,4,5,8,8,2,1,9,2,7,9,12,1,7,12,2,6]
	r9 =  [6,4,1,2,12,2,1,13,1,7,9,6,1,13,13,12,9,5,5,3,12,11,11,10,9,2,13,3,10,2,11,8,10,8,11,7,10,6,5,4,12,7,4,3,9,7,8,6,8,4,5,3]
	assert War.deal(t9) == r9
  end

  test "deal_10" do
	t10 = [11,8,3,8,4,5,13,6,10,4,9,13,2,6,12,12,1,3,2,8,4,5,11,5,8,12,6,5,9,4,10,10,6,10,11,2,1,2,3,7,11,13,13,1,12,9,1,7,7,9,7,3]
	r10 = [7,4,10,9,6,5,10,9,8,3,13,12,10,6,11,8,8,3,12,5,6,4,11,3,4,2,1,12,1,13,1,8,1,2,13,11,12,9,11,9,6,4,7,3,5,2,5,2,13,10,7,7]
	assert War.deal(t10) == r10
  end

  test "deal_11" do
	t11 = [10,2,3,4,12,7,6,3,5,5,10,6,4,1,3,5,13,5,12,7,3,2,6,11,1,8,13,8,2,11,1,4,11,12,11,1,9,4,7,10,12,13,13,6,8,10,9,2,8,9,7,9]
	r11 = [7,3,1,13,12,12,11,11,10,5,10,10,9,7,4,3,7,3,6,2,1,1,8,7,2,2,1,8,12,2,11,10,8,6,13,6,9,9,5,5,5,3,13,13,12,11,8,4,9,6,4,4]
	assert War.deal(t11) == r11
  end
end
