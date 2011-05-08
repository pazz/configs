if args =~ /--encrypt/
  "--trust-model always #{args}"
else
  args
end
