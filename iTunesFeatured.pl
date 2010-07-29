#!/usr/bin/perl

# Created by Ortwin Gentz on 27.04.09.
#
# Copyright 2010 FutureTap. All rights reserved.
# http://www.futuretap.com/blog/scraping-app-store-featured-entries/
#
# This work is licensed under a Creative Commons Attribution-Share Alike 3.0 Unported License
# http://creativecommons.org/licenses/by-sa/3.0/
#
# If you use this script, I'd be glad to know. Just shoot me a tweet @futuretap
# or a mail at info@futuretap.com.


%iso2store = (
	"ar" => 143505,
	"au" => 143460,
	"be" => 143446,
	"br" => 143503,
	"ca" => 143455,
	"cl" => 143483,
	"cn" => 143465,
	"co" => 143501,
	"cr" => 143494,
	"cz" => 143489,
	"dk" => 143458,
 	"de" => 143443,
	"sv" => 143506,
	"es" => 143454,
	"fi" => 143447,
	"fr" => 143442,
	"gr" => 143448,
	"gt" => 143504,
	"hk" => 143463,
	"hu" => 143482,
	"in" => 143467,
	"id" => 143476,
	"ie" => 143449,
	"il" => 143491,
	"it" => 143450,
	"kr" => 143466,
	"kw" => 143493,
	"lb" => 143497,
	"lu" => 143451,
	"my" => 143473,
	"mx" => 143468,
	"nl" => 143452,
	"nz" => 143461,
	"no" => 143457,
	"at" => 143445,
	"pk" => 143477,
	"pa" => 143485,
	"pe" => 143507,
	"ph" => 143474,
	"pl" => 143478,
	"pt" => 143453,
	"qa" => 143498,
	"ro" => 143487,
	"ru" => 143469,
	"sa" => 143479,
	"ch" => 143459,
	"sg" => 143464,
	"sk" => 143496,
	"si" => 143499,
	"za" => 143472,
	"lk" => 143486,
	"se" => 143456,
	"tw" => 143470,
	"th" => 143475,
	"tr" => 143480,
	"ae" => 143481,
	"gb" => 143444,
	"ve" => 143502,
	"vn" => 143471,
	"jp" => 143462,
	"us" => 143441
);

my %genres = (
	"Books" => 6018,
	"Business" => 6000,
	"Education" => 6017,
	"Entertainment" => 6016,
	"Finance" => 6015,
	"Games" => 6014,
	"Health &amp; Fitness" => 6013,
	"Lifestyle" => 6012,
	"Medical" => 6020,
	"Music" => 6011,
	"Navigation" => 6010,
	"News" => 6009,
	"Photography" => 6008,
	"Productivity" => 6007,
	"Reference" => 6006,
	"Social Networking" => 6005,
	"Sports" => 6004,
	"Travel" => 6003,
	"Utilities" => 6002,
	"Weather" => 6001
);
my %categories = (
	"Top Overall"		=> 25204,
	"Top Overall Revenue" => 25210,
	"Books"				=> 25470,
	"Business"			=> 25148,
	"Education"			=> 25156,
	"Entertainment"		=> 25164,
	"Finance"			=> 25172,
	"Healthcare & Fitness"		=> 25188,
	"Lifestyle"			=> 25196,
	"Medical"			=> 26321,
	"Music"				=> 25212,
	"Navigation"		=> 25226,
	"News"				=> 25228,
	"Photography"		=> 25236,
	"Productivity"		=> 25244,
	"Reference"			=> 25252,
	"Social Networking"	=> 25260,
	"Sports"			=> 25268,
	"Travel"			=> 25276,
	"Utilities"			=> 25284,
	"Weather"			=> 25292,
	"All Games"			=> 25180,
	"Games/Action"		=> 26341,
	"Games/Adventure"	=> 26351,
	"Games/Arcade"		=> 26361,
	"Games/Board"		=> 26371,
	"Games/Card"		=> 26381,
	"Games/Casino"		=> 26341,
	"Games/Dice"		=> 26341,
	"Games/Educational"	=> 26411,
	"Games/Family"		=> 26421,
	"Games/Kids"		=> 26431,
	"Games/Music"		=> 26441,
	"Games/Puzzle"		=> 26451,
	"Games/Racing"		=> 26461,
	"Games/Role Playing"=> 26471,
	"Games/Simulation"	=> 26481,
	"Games/Sports"		=> 26491,
	"Games/Strategy"	=> 26501,
	"Games/Trivia"		=> 26511,
	"Games/Word"		=> 26521,
);

$appId = shift;
$categoryName = shift;
$mode = shift;
$mode = lc$mode;
if($mode eq ""){
    $mode = "iphone";
}

($appId =~ m/^\d+$/) || die "Usage: itFeatured.pl <numerical app ID> <category (Medical, Utilities etc.)> [<store (iPad,iPhone)>]\n\n";
$date = `date "+%d.%m.%Y"`;
chomp $date;

foreach $country (sort(keys %iso2store)) {
	my $matchesRoot = "";
	my $matchesCategory = "";
	$matchesRoot = printFeaturingForAppIdCountryAndCategory($appID, $country, "",$mode);
	$matchesCategory = printFeaturingForAppIdCountryAndCategory($appID, $country, $categoryName,$mode);
	
	if ("$matchesRoot$matchesCategory" ne "") {
		if ($matchesRoot ne "") {
			$matchesRoot = "App Store: $matchesRoot";
		}
		$matchesRoot .= "\t";
		if ($matchesCategory ne "") {
			$matchesCategory = "$categoryName: $matchesCategory";
		}
		print "$date\t" . uc($country) . "\t" . $matchesRoot . $matchesCategory . "\n";
	}
}

exit 0;

sub printFeaturingForAppIdCountryAndCategory {
	my ($appID, $country, $categoryName, $mode) = @_;

	my $storefront = $iso2store{$country};
	my $categoryId = $categories{$categoryName};
	my $genreId = $genres{$categoryName};
	
	my $xml, $homepageURL;
	if ($categoryName eq "") {
		##print "## case 1: ";
		$genreId=36;
	} else {
		##print "## case 2: ";
	}	
	$xml = `curl -s -H "X-Apple-Store-Front: $storefront-1,5"  "http://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewGenre?id=$genreId&mt=8"`;
	if ($xml =~ m!<string>http://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewGrouping\?id=(\d+)\&amp;mt=8</string>!) {
		$homepageURL = "http://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewGrouping?id=$1&mt=8&pillIdentifier=$mode";
	} else {
		return "\nhomepageURL not found for $country $categoryName\n";
	}
	
	##print "checking $country $homepageURL\n";
	
		
	if($homepageURL) {
		$xml = `curl -s -H "X-Apple-Store-Front: $storefront,5"  "$homepageURL"`;
		my $matches = "";
		$xml =~ tr/\n//d; # delete all linebreaks
		
		if ($xml =~ m!http://ax.itunes.apple.com/../app/.+/id$appId!) {
			$matches .= "Home page ";
		}

		if ($xml =~ m!<h\d>(New and Noteworthy|New &amp; Noteworthy|NEU UND BEACHTENSWERT|NUEVO Y DIGNO DE DESTACAR|NUOVE E DEGNE DI NOTA|Nuovi e da segnalare|ニューリリースと注目作品|注目の新作|Nieuw en opmerkelijk|Nouveautés).+?(http://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewRoom[^">]+)">!i) {
			##print "## found new\n";
			if (fetchAndGrep($storefront, $2, $appId)) {
				$matches .= "NEW AND NOTEWORTHY ";
			}
		} 
		if ($xml =~ m!<h\d>(What's Hot|TOPAKTUELL|Lo último|Più richieste|Nieuw en opmerkelijk|Actualités).+?(http://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewRoom[^"]+)!i) {
			##print "## found hot\n";
			if (fetchAndGrep($storefront, $2, $appId)) {
				$matches .= "WHAT'S HOT ";
			}
		} 
		if ($xml =~ m!<h\d>(STAFF FAVORITES|STAFF FAVOURITES|TIPPS DER REDAKTION|NUESTRAS SUGERENCIAS|CONSIGLIATI DALLO STAFF|スタッフのおすすめ|FAVORIET BIJ ONZE MEDEWERKERS|Recommandées).+?(http://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewRoom[^"]+)!i) {
			##print "## found staff\n";
			if (fetchAndGrep($storefront, $2, $appId)) {
				$matches .= "STAFF FAVORITES ";
			}
		} 
		return $matches;
	} else {
		return "parse error for 'curl -s -H \"X-Apple-Store-Front: $storefront\"  \"$homepageURL\"'\n";
	}
}

sub fetchAndGrep {
	my($storefront, $url, $appid) = @_;
	##print "## fetch and grep for storefront:$storefront, url:$url, appid:$appid\n";
	my $xml = `curl -s -H "X-Apple-Store-Front: $storefront,5" '$url'`;
	#$xml .= `curl -s -H "X-Apple-Store-Front: $storefront,5" '$url&batchNumber=1'`;
	#$xml =~ tr/\n//d; # delete all linebreaks
	return ($xml =~ m!id$appid!);
}
