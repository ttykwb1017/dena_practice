package Schedular::Web::Dispatcher;
# 文法チェック
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;
use Time::Piece;
# my $xx; スカラ変数の定義
# my @xx; 配列変数の定義
# $i++ iをインクリメント
get '/' => sub {
    my ($c) = @_;
    my $order = $c->req->parameters->{order} // "";
    my @schedules;
    if ($order eq 'reverse') {
        @schedules = $c->db->search('schedules', {}, { order_by => 'date ASC'});
      }
    else{
       @schedules = $c->db->search('schedules', {}, { order_by => 'date DESC'});
    }

    my $kyou_epoch_detail = localtime;
    my $kyou_epoch = $kyou_epoch_detail->strftime('%Y/%m/%d');
#    print STDERR $order . "\n";
  
   return $c->render('index.tx', { schedules => \@schedules ,kyou_epoch => $kyou_epoch} );
};

post '/post' =>sub {
    my ($c) = @_;

    my $title = $c->req->parameters->{title}; 
    my $date  = $c->req->parameters->{date};
    my $date_epoch = Time::Piece->strptime($date, '%Y/%m/%d')->epoch;

    $c->db->insert(schedules => { 
        title => $title,          
        date  => $date_epoch,     
    });                           
            
    return $c->redirect('/');
 };    
      
post '/schedules/:id/delete' => sub {
    my ($c, $args) = @_;
    my $id = $args->{id};
 
    $c->db->delete('schedules' => { id => $id });
    return $c->redirect('/');
 };

post '/accounts/post' => sub{ 
    my ($c) = @_;
    my $content = $c->req->parameters->{content}; 
    my $date  = $c->req->parameters->{date};
    my $category = $c->req->parameters->{category}; 
    my $money  = $c->req->parameters->{money};
    my $date_epoch = Time::Piece->strptime($date, '%Y/%m/%d')->epoch;

    $c->db->insert(accounts => { 
        content => $content,          
        date  => $date_epoch,
        category => $category,
        money => $money,
    });                           
            
    return $c->redirect('/accounts');
};

get '/accounts' => sub {
    my ($c) = @_;
    my @accounts = $c->db->search('accounts', {}, { order_by => 'date DESC'});
    my @transform = ("Groceries", "Commodities", "Socializing costs", "Utility charges", "Others");
    my @watasu = ();

    for my $account (@accounts){
        my $hoge = $transform[$account->category - 1];
        my %hassyu = ("id" => $account->id, "content" => $account->content, "date" => $account->date, "money" => $account->money, "category" => $hoge);
        push(@watasu, \%hassyu);
    }


    return $c->render('account.tx', {accounts => \@watasu} );
};

post '/accounts/:id/delete' => sub {
    my ($c, $args) = @_;
    my $id = $args->{id};
 
    $c->db->delete('accounts' => { id => $id });
    return $c->redirect('/accounts');
 };

1;
