class Monkey
  attr_reader :id, :inspection_count

  def initialize(id, items, operation, throw_test)
    @id = id
    @items = items
    @operation = operation
    @test = throw_test
    @inspection_count = 0
  end

  def catch_item(item)
    @items << item
  end

  def inspect_item(lcm)
    @items[0] = @operation.operate(@items.first) % lcm
    @inspection_count += 1
  end

  def throw_item
    @items.shift
  end

  def throw_recipient
    @test.throw_recipient(@items.first)
  end

  def empty_handed?
    @items.empty?
  end
end

class Operation
  def initialize(num1, num2, operator)
    @num1 = num1
    @num2 = num2
    @operator = operator
  end

  def operate(old)
    num1 = @num1 == 'old' ? old : @num1.to_i
    num2 = @num2 == 'old' ? old : @num2.to_i
    num1.public_send(@operator, num2)
  end
end

class Test
  def initialize(divisor, positive_move, negative_move)
    @divisor = divisor
    @positive_move = positive_move
    @negative_move = negative_move
  end

  def throw_recipient(worry_level)
    (worry_level % @divisor).zero? ? @positive_move : @negative_move
  end
end

class Troop
  def initialize
    @troop = {}
    @lcm = 1
    parse_troop_data
    play_20_rounds
  end

  def monkey_business_level
    (0...@troop.length).map { |id| @troop[id].inspection_count }.sort.last(2).reduce(1, :*)
  end

  private

  def play_20_rounds
    10_000.times do
      0.upto(@troop.size - 1) do |id|
        next if @troop[id].empty_handed?

        take_turn(@troop[id])
      end
    end
  end

  def play_round
    0.upto(@troop.size - 1) do |i|
      next if @troop[i].empty_handed?

      take_turn(@troop[i])
    end
  end

  def take_turn(cur_monkey)
    until cur_monkey.empty_handed?
      cur_monkey.inspect_item(@lcm)
      recipient_monkey = @troop[cur_monkey.throw_recipient]
      recipient_monkey.catch_item(cur_monkey.throw_item)
    end
  end

  def parse_troop_data
    File.open('input.txt').read.split("\n\n").each do |monkey_data|
      new_monkey = create_monkey(monkey_data)
      @troop[new_monkey.id] = new_monkey
    end
  end

  def create_monkey(monkey_data)
    monkey_data = monkey_data.split("\n")
    id = monkey_data[0].scan(/\d+/).first.to_i
    items = monkey_data[1].scan(/\d+/).map(&:to_i)
    operation = create_operation(monkey_data[2])
    throw_test = create_test(monkey_data[3..5])
    Monkey.new(id, items, operation, throw_test)
  end

  def create_operation(line)
    num1, operator, num2 = line.split.last(3)
    Operation.new(num1, num2, operator)
  end

  def create_test(lines)
    divisor, positive_move, negative_move = lines.map { |line| line.strip.split.last.to_i }
    @lcm *= divisor
    Test.new(divisor, positive_move, negative_move)
  end
end

puts "Monkey business level: #{Troop.new.monkey_business_level}"
