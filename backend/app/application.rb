class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    # binding.pry

    if req.path.match(/test/) 
      return [200, { 'Content-Type' => 'application/json' }, [ {:message => "test response!"}.to_json ]]

    elsif req.path.match(/comics/)
      if req.env["REQUEST_METHOD"] =="POST"
        input = JSON.parse(req.body.read)
        client_id = req.path.split("/clients/").last.split("/comics").last
        client = Client.find_by(id: client_id)
        comic = client.comics.create(title: input["title"], publisher: input["publisher"], creators: input["creators"], img_url: input["img_url"], price: input["price"])
        return [200, { 'Content-Type' => 'application/json' }, [ comic.to_json ]]
      elsif req.env["REQUEST_METHOD"] =="DELETE"
        client_id = req.path.split("/clients/").last.split("/comics/").first
        client = Client.find_by(id: client_id)
        # binding.pry
        comic_id = req.path.split("/comics/").last
        client.comics.find_by(id: comic_id).destroy
      else
        # binding.pry
        if req.path.split("/comics").length == 0
          return [200, { 'Content-Type' => 'application/json' }, [ Comic.all.to_json ]]
        
        else
          # binding.pry
          comic_id = req.path.split("/comics/").last
          return [200, { 'Content-Type' => 'application/json' }, [ Comic.find_by(id: comic_id).to_json ]]
        
        end
      end
    elsif req.path.match(/clients/) 
      if req.env["REQUEST_METHOD"] =="POST"
        input = JSON.parse(req.body.read)
        client = Client.create(name: input["name"], phone_number: input["phone_number"], email: input["email"])
        return [200, { 'Content-Type' => 'application/json' }, [ client.to_json ]]
    
      else
        if req.path.split("/clients").length == 0
          return [200, { 'Content-Type' => 'application/json' }, [ Client.all.to_json ]]
      
        else
          client_id = req.path.split("/clients/").last
          return [200, { 'Content-Type' => 'application/json' }, [ Client.find_by(id: client_id).to_json({:include => :comics}) ]]
        
        end
      end
    else
      resp.write "Path Not Found"

    end

    resp.finish
  end

end