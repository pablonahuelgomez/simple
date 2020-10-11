defprotocol Simple.Statement do
  def reducible?(statement)
  def reduce(expression, environment)
end
