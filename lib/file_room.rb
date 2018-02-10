require "file_room/version"

module FileRoom
  def self.included(klass)
    klass.extend ClassMethods
  end
  
  module ClassMethods
    def watch(*m)
      if m[0] == :all
        @@defined_methods = Hash.new
        def self.method_added(method_name)
          if @@defined_methods[method_name] == nil
            @@defined_methods[method_name] = true
            context = Module.new do
              define_method(method_name) do |*args,&blk|
                save_method_call(__method__, args)
                super *args, &blk
              end
              
              def save_method_call(current_method, *args)
                MethodCallEntry.create(class_name: self.class, method_name: current_method, args: args)
              end
            end
            self.prepend context
          end
        end
      else
        proxy = Module.new do
          m.each do |mname|
            define_method(mname) do |*args,&blk|
              save_method_call(__method__, args)
              super *args, &blk
            end
          end
          
          def save_method_call(current_method, *args)
            MethodCallEntry.create(class_name: self.class, method_name: current_method, args: args)
          end
        end
        self.prepend(proxy)
      end
    end
  end
end
