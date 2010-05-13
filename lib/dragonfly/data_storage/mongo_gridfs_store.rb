require 'mongoid'

module Dragonfly
  module DataStorage

    class MongoGridfsStore < Base
      
      include Configurable
      
      configurable_attr :grid_fs_database
      
      def store(temp_object)

        db = Mongo::Connection.new.db(grid_fs_database)
        grid = Mongo::Grid.new(db)

        # returns object id
        id = grid.put(File.read(temp_object.path), :filename => temp_object.basename)
        id
      end

      def retrieve(uid)
        db = Mongo::Connection.new.db(grid_fs_database)
        grid = Mongo::Grid.new(db)
        file = grid.get(uid)
        file.read
      end
      
      def destroy(uid)
        db = Mongo::Connection.new.db(grid_fs_database)
        grid = Mongo::Grid.new(db)
        grid.delete(Mongo::ObjectID.from_string(uid))
      end
    end
  end
end
