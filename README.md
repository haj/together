= Together

Together is a Multi-tennant collaboration Platform. It will handle your users, signup, groups, memberships and invitations. All data scoped to a domain (as in dns domain) based on signed-in user's email. It uses postgres schema's

It is a Rails Engine.

== Devise

Together is based on devise. It comes with a default configuration and migration for devise specifically for collaboration platforms. It requires mostly the same stuff.

To use:

- make sure you have a route to root
- make sure you display alerts & notices in your application layout
- set the default host for action mailer:

    config.action_mailer.default_url_options = { :host => 'localhost:3000' }

== Multi-tennant

