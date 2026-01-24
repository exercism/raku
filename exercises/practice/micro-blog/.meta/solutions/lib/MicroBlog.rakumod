unit module MicroBlog;

sub post (Str :$tweet) is export { $tweet.substr: ^5 }
