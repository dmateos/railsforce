class SequenceError < StandardError
  def initialize(msg)
    super(msg)
  end
end

class SequenceParser
  attr_reader :data_sequence

  def initialize(data_sequence, options = {})
    @data_sequence = data_sequence;
    @options = options
  end

  def parse
    if @options[:single]
      return parse_single
    elsif @options[:multi]
      return parse_multiple
    end

    raise SequenceError.new("no option specified")
  end

  private
  def parse_single(ds = data_sequence)
    x, y = ds.data.split(",")
    { x: x, y: y }
  end

  def parse_multiple
    data_sequence.map { |seq| parse_single(seq) } 
  end
end
