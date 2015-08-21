var ComputeRefXFilter = function(sprite)
{
  return String(sprite.untrimmedSize.width/2 - sprite.sourceRect.x);
};
ComputeRefXFilter.filterName = "computeRefX";
ComputeRefXFilter.isSafe = false;
Library.addFilter("ComputeRefXFilter");

var ComputeRefYFilter = function(sprite)
{
  return String(sprite.untrimmedSize.height/2 - sprite.sourceRect.y);
};
ComputeRefYFilter.filterName = "computeRefY";
ComputeRefYFilter.isSafe = false;
Library.addFilter("ComputeRefYFilter");

var ComputeX2Filter = function(input)
{
  return String(input.x + input.width);
};
ComputeX2Filter.filterName = "computeX2";
ComputeX2Filter.isSafe = false;
Library.addFilter("ComputeX2Filter");

var ComputeY2Filter = function(input)
{
  return String(input.y + input.height);
};
ComputeY2Filter.filterName = "computeY2";
ComputeY2Filter.isSafe = false;
Library.addFilter("ComputeY2Filter");



