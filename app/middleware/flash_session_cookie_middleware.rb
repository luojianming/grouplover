require 'rack/utils'

class FlashSessionCookieMiddleware
  def initialize(app, key = '_fly84_session')
    @app = app
    @session_key = key
  end

  def call(env)
    if env['HTTP_USER_AGENT'] =~ /^(Adobe|Shockwave) Flash/
 #     params = ::Rack::Utils.parse_query(env['QUERY_STRING'])
      req = Rack::Request.new(env)
      env['HTTP_COOKIE'] = [ @session_key, req.params[@session_key] ].join('=').freeze unless req.params[@session_key].nil?
    end
    @app.call(env)
  end
end
