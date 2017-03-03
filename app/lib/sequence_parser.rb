class SequenceError < StandardError
  def initialize(msg)
    super(msg)
  end
end

class SequenceParser
  attr_reader :data_sequence

  def initialize(data_sequence, options = {})
    @data_sequence = data_sequence
    @options = options
  end

  def parse
    return parse_single if @options[:single]
    return parse_multiple if @options[:multi]
    raise SequenceError.new("no option specified")
  end

  private
  def parse_single(ds = data_sequence)
    x, y = ds.data.split(",")
    { series: ds.series, x: x, y: y }
  end

  def parse_multiple
    data_sequence.map { |seq| parse_single(seq) }
  end
end
