class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/test/) 
      return [200, { 'Content-Type' => 'application/json' }, [ {:message => "test response!"}.to_json ]]

    elsif req.path.match(/clients/) 
      if re.path.split("/clients").length == 0
        return [200, { 'Content-Type' => 'application/json' }, [ clients.all.to_json ]]
      else
        client_id = re.path.split("/clients/").last
    else
      resp.write "Path Not Found"

    end

    resp.finish
  end

end
