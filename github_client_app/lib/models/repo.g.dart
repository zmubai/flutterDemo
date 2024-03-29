// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Repo _$RepoFromJson(Map<String, dynamic> json) {
  return Repo()
    ..id = json['id'] as num
    ..node_id = json['node_id'] as String
    ..name = json['name'] as String
    ..full_name = json['full_name'] as String
    ..private = json['private'] as bool
    ..owner = json['owner'] as Map<String, dynamic>
    ..html_url = json['html_url'] as String
    ..description = json['description'] as String
    ..fork = json['fork'] as bool
    ..url = json['url'] as String
    ..forks_url = json['forks_url'] as String
    ..keys_url = json['keys_url'] as String
    ..collaborators_url = json['collaborators_url'] as String
    ..teams_url = json['teams_url'] as String
    ..hooks_url = json['hooks_url'] as String
    ..issue_events_url = json['issue_events_url'] as String
    ..events_url = json['events_url'] as String
    ..assignees_url = json['assignees_url'] as String
    ..branches_url = json['branches_url'] as String
    ..tags_url = json['tags_url'] as String
    ..blobs_url = json['blobs_url'] as String
    ..git_tags_url = json['git_tags_url'] as String
    ..git_refs_url = json['git_refs_url'] as String
    ..trees_url = json['trees_url'] as String
    ..statuses_url = json['statuses_url'] as String
    ..languages_url = json['languages_url'] as String
    ..stargazers_url = json['stargazers_url'] as String
    ..contributors_url = json['contributors_url'] as String
    ..subscribers_url = json['subscribers_url'] as String
    ..subscription_url = json['subscription_url'] as String
    ..commits_url = json['commits_url'] as String
    ..git_commits_url = json['git_commits_url'] as String
    ..comments_url = json['comments_url'] as String
    ..issue_comment_url = json['issue_comment_url'] as String
    ..contents_url = json['contents_url'] as String
    ..compare_url = json['compare_url'] as String
    ..merges_url = json['merges_url'] as String
    ..archive_url = json['archive_url'] as String
    ..downloads_url = json['downloads_url'] as String
    ..issues_url = json['issues_url'] as String
    ..pulls_url = json['pulls_url'] as String
    ..milestones_url = json['milestones_url'] as String
    ..notifications_url = json['notifications_url'] as String
    ..labels_url = json['labels_url'] as String
    ..releases_url = json['releases_url'] as String
    ..deployments_url = json['deployments_url'] as String
    ..created_at = json['created_at'] as String
    ..updated_at = json['updated_at'] as String
    ..pushed_at = json['pushed_at'] as String
    ..git_url = json['git_url'] as String
    ..ssh_url = json['ssh_url'] as String
    ..clone_url = json['clone_url'] as String
    ..svn_url = json['svn_url'] as String
    ..homepage = json['homepage'] as String
    ..size = json['size'] as num
    ..stargazers_count = json['stargazers_count'] as num
    ..watchers_count = json['watchers_count'] as num
    ..language = json['language'] as String
    ..has_issues = json['has_issues'] as bool
    ..has_projects = json['has_projects'] as bool
    ..has_downloads = json['has_downloads'] as bool
    ..has_wiki = json['has_wiki'] as bool
    ..has_pages = json['has_pages'] as bool
    ..forks_count = json['forks_count'] as num
    ..mirror_url = json['mirror_url'] as String
    ..archived = json['archived'] as bool
    ..disabled = json['disabled'] as bool
    ..open_issues_count = json['open_issues_count'] as num
    ..license = json['license'] as String
    ..forks = json['forks'] as num
    ..open_issues = json['open_issues'] as num
    ..watchers = json['watchers'] as num
    ..default_branch = json['default_branch'] as String
    ..network_count = json['network_count'] as num
    ..subscribers_count = json['subscribers_count'] as num;
}

Map<String, dynamic> _$RepoToJson(Repo instance) => <String, dynamic>{
      'id': instance.id,
      'node_id': instance.node_id,
      'name': instance.name,
      'full_name': instance.full_name,
      'private': instance.private,
      'owner': instance.owner,
      'html_url': instance.html_url,
      'description': instance.description,
      'fork': instance.fork,
      'url': instance.url,
      'forks_url': instance.forks_url,
      'keys_url': instance.keys_url,
      'collaborators_url': instance.collaborators_url,
      'teams_url': instance.teams_url,
      'hooks_url': instance.hooks_url,
      'issue_events_url': instance.issue_events_url,
      'events_url': instance.events_url,
      'assignees_url': instance.assignees_url,
      'branches_url': instance.branches_url,
      'tags_url': instance.tags_url,
      'blobs_url': instance.blobs_url,
      'git_tags_url': instance.git_tags_url,
      'git_refs_url': instance.git_refs_url,
      'trees_url': instance.trees_url,
      'statuses_url': instance.statuses_url,
      'languages_url': instance.languages_url,
      'stargazers_url': instance.stargazers_url,
      'contributors_url': instance.contributors_url,
      'subscribers_url': instance.subscribers_url,
      'subscription_url': instance.subscription_url,
      'commits_url': instance.commits_url,
      'git_commits_url': instance.git_commits_url,
      'comments_url': instance.comments_url,
      'issue_comment_url': instance.issue_comment_url,
      'contents_url': instance.contents_url,
      'compare_url': instance.compare_url,
      'merges_url': instance.merges_url,
      'archive_url': instance.archive_url,
      'downloads_url': instance.downloads_url,
      'issues_url': instance.issues_url,
      'pulls_url': instance.pulls_url,
      'milestones_url': instance.milestones_url,
      'notifications_url': instance.notifications_url,
      'labels_url': instance.labels_url,
      'releases_url': instance.releases_url,
      'deployments_url': instance.deployments_url,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'pushed_at': instance.pushed_at,
      'git_url': instance.git_url,
      'ssh_url': instance.ssh_url,
      'clone_url': instance.clone_url,
      'svn_url': instance.svn_url,
      'homepage': instance.homepage,
      'size': instance.size,
      'stargazers_count': instance.stargazers_count,
      'watchers_count': instance.watchers_count,
      'language': instance.language,
      'has_issues': instance.has_issues,
      'has_projects': instance.has_projects,
      'has_downloads': instance.has_downloads,
      'has_wiki': instance.has_wiki,
      'has_pages': instance.has_pages,
      'forks_count': instance.forks_count,
      'mirror_url': instance.mirror_url,
      'archived': instance.archived,
      'disabled': instance.disabled,
      'open_issues_count': instance.open_issues_count,
      'license': instance.license,
      'forks': instance.forks,
      'open_issues': instance.open_issues,
      'watchers': instance.watchers,
      'default_branch': instance.default_branch,
      'network_count': instance.network_count,
      'subscribers_count': instance.subscribers_count
    };
