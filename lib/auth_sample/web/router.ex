defmodule AuthSample.Web.Router do
  use AuthSample.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/", AuthSample.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

   scope "/api", AuthSample.Web do
     pipe_through :api
     post "/log-in", SessionController, :create
     get "/secret", SecrectController, :index
   end
end
