require "spec_helper"

describe SessionsController do
  describe "routing" do
    it "routes to #create" do
      post("/sessions").should route_to("sessions#create")
    end

    it "routes to #destroy" do
      delete("/sessions").should route_to("sessions#destroy")
    end

    it "routes /signout to #destroy" do
      delete('/signout').should route_to('sessions#destroy')
    end

    it "routes /auth/google/callback to sessions#create" do
      post('auth/google/callback').should route_to(
        'sessions#create', provider: 'google'
      )
    end

  end
end
