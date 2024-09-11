defmodule ReglitoWeb.Router do
  use ReglitoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ReglitoWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  scope "/", ReglitoWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/info", PageController, :info

    live_session :live do
      live "/start", StartLive
      live "/chapters_selection", ChaptersSelectionsLive
      live "/cooperative", CooperativeLive
    end
  end

  scope "/api", ReglitoWeb do
    pipe_through :api

    get "/register", SessionController, :modify_session
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:reglito, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ReglitoWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
