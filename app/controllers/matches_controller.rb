class MatchesController < ApplicationController
	before_action :resync_matches, only: :index

def index
  # several orders of magnitude faster
  
  @matched_users = current_user.matched_users
                               .page(params[:page])
end

private

def resync_matches
  # only resync if we have to
  if current_user.matches_outdated?
    new_matches = MatchMaker.matches_for(current_user)
    current_user.matched_users.replace(new_matches)
  end
end

end
