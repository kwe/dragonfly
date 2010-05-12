require 'mongoid'

module Dragonfly
  module DataStorage

    class MongoGridfsStore < Base
      
#      include Configurable
      
#      configurable_attr :grid_fs_database
      
      def store(temp_object)

        db = Mongo::Connection.new.db(Mogoid.database)
        grid = Mongo::Grid.new(db)

        # returns object id
        id = grid.put(File.read(temp_object.path), :filename=>'something.jpg')
        id
      end

      def retrieve(uid)
        db = Mongo::Connection.new.db(Mongoid.database)
        grid = Mongo::Grid.new(db)
        file = grid.get(Mongo::ObjectID.from_string(uid))
        file.read
      end
      
      def destroy(uid)
        db = Mongo::Connection.new.db(Mongoid.database)
        grid = Mongo::Grid.new(db)
        grid.delete(Mongo::ObjectID.from_string(uid))
      end
    end
  end
end
