Factory.define :rate do |r|
  r.valid_from Date.today
  r.rate 50.0
end