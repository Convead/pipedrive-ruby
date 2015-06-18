module Pipedrive
  class SearchResult < Base

    # Class Methods
    class << self

      def search(term, options = {})
        options[:start] ||= 0
        query_options = options.merge(:term => term)

        res = get(resource_path, :query => query_options)
        if res.ok?
          res['data'].nil? ? [] : res['data'].map{|obj| new(obj)}
        else
          bad_response(res,{:term=>term,:start=>options[:start],:limit=>options[:limit]})
        end
      end
  
      def field(term, field_type, field_key, opts={})
        res = get("#{resource_path}/field", :query => opts.merge(:term => term, :field_type => field_type, :field_key => field_key) )
        if res.ok?
          res['data'].nil? ? [] : res['data'].map{|obj| new(obj)}
        else
          bad_response(res,{:term=>term,:field_type=>field_type,:field_key=>field_key}.merge(opts))
        end
      end
    
    end
    
  end
end
