defprotocol Simple.Expression do
  def reducible?(expression)
  def reduce(expression, environment)
end
