class Factory

  def self.new( *arguments, &block )
   Class.new do
     @@arguments = arguments
     arguments.each { |arg| attr_accessor arg }
     define_method :initialize do |*arg_val|
       arg_val.each_with_index { |value, index| instance_variable_set("@#{arguments[index]}", value) }
      end

  def [](index)
  	if index.class == String
  		self.instance_variable_get("@#{index}")
   	elsif index.integer? 
  		self.instance_variable_get("@#{@@arguments[index]}")
   	end
  end
 	  yield(block) if block_given?
  end
 end
end
	
  Customer = Struct.new(:name, :address, :zip) do
    def greeting
     "Hello #{name}!"
    end
  end
 
  human = Customer.new("Steve Liger", "350 Avenue, New York", 54321)
  puts human.name
  puts human["address"]
  puts human[:name]
  puts human[2]
  puts human.greeting 

#Factory result:
#Steve Liger
#350 Avenue, New York
#Steve Liger
#54321
#Hello Steve Liger!

