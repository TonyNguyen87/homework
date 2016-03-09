require "json"

module Homework
  class Github
    include HTTParty
    base_uri "https://api.github.com"

    def initialize
      @auth_token = "7097428a0d4bf47b77e49e99575e61107b678fcf"
      @headers = {
        "Authorization" => "token #{@auth_token}",
        "User-Agent"    => "HTTParty"
      }
    end

    def get_user(username)
      Github.get("/users/#{username}", headers: @headers)
    end

    def list_members_by_team_name(org, team_name)
      teams = list_teams(org)
      team = teams.find { |team| team["name"] == team_name }
      list_team_members(team["id"])
    end

    def list_teams(organization)
      Github.get("/orgs/#{organization}/teams", headers: @headers)
    end

    def list_team_members(team_id)
      Github.get("/teams/#{team_id}/members", headers: @headers)
    end

    def list_issues(owner, repo) #rails organization has rail issue, kingcons, coleslaw, cl-6502, rails, rails,
      Github.get("/repos/#{owner}/#{repo}/issues", headers: @headers)
    end
 
    def close_issue(owner, repo, issue_num)
      Github.patch("/repos/#{owner}/#{repo}/issues/#{issue_num}", headers: @headers, :state => { option: "closed" }.to_json)
    end

    def comment_issue(owner, repo, issue_num, comment)
      Github.patch("/repos/#{owner}/#{repo}/issues/#{issue_num}/comments", headers: @headers, :body => { option: "#{comment}" }.to_json)
    end
  end
end

