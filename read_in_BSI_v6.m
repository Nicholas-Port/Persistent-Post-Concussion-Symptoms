% read_in_BSI_v6valdt


%
disp('Read table 1');
T1 = readtable('../CARE_20/CARE_Baselines_2021_09_29_data_ran_2021_10_05.csv'              );
%T1 = readtable('../care_data/CARE1Full_Baselines_23FEB2021_data_ran_26FEB2021.csv'              );
%T1 = readtable('../CARE_1Full_Feb23_Files/CARE1Full_Baselines_23FEB2021_data_ran_26FEB2021.csv'     );
      

% Start Parsing the Baseline file


clear sub 
%clear num_base num_base2


% Key
% Column - Function
% 9   - Which TimePoint ('Base' '24' 'Asmp' 'Unrestrict' '6Mo' )
% 10  - TimePoint Index (1-13)
% 481 - Voms Done
% 488 - VOMS Baseline Dizzy
% 489 - VOMS Baseline Fog
% 490 - VOMS Baseline Heachache
% 491 - VOMS Baseline Nausea



% Inits
sub         = [];
r           = 0;
fubar       = 0;
s           = 0;
sub_id_list = [];

% Initialize sub
for r = 1:size(T1,1)
   
   temp_sub_id = T1{r,3};
   
   i=find(sub_id_list == temp_sub_id);
   
   if isempty(i) % i is empty so temp_sub_id is NEW
      
      s  = s + 1;
      s2 = s;
      sub_id_list(s)     = temp_sub_id;
      sub(s2).sub_id     = temp_sub_id;
      sub(s2).n_baseline = 1;
      sub(s2).n_injuries = 0;
      sub(s2).injury_id  = [];
      
   else
      fubar = fubar + 1;
      s2 = i;
      sub(s2).n_baseline = sub(s2).n_baseline + 1;
   end %if
      
   b = sub(s2).n_baseline;
   
   sub(s2).base(b).siteid         = T1{r,1};
   sub(s2).base(b).ncaacategory   = T1{r,7};
   sub(s2).base(b).division       = T1{r,8};

   sub(s2).base(b).baselineevalid = T1{r,15}; %
   sub(s2).base(b).evaldate       = T1{r,16}; 
   sub(s2).base(b).race           = T1{r,21};
   sub(s2).base(b).ethnicity      = T1{r,22};
   sub(s2).base(b).weight         = T1{r,23};
   sub(s2).base(b).height         = T1{r,24};
   sub(s2).base(b).BMI            = T1{r,25};
   %sub(s2).base(b).valdt          = T1{r,17};  % Not in CARE 2.0
   sub(s2).base(b).age            = T1{r,26};
   sub(s2).base(b).sport          = T1{r,66};
   
   sub(s2).base(b).medhxconhxcompletestatus  = T1{ r, 239 }; % "Complete" or "No Data Collected"     % Need to use this otherwise the zeros in column 246 are misleading
   sub(s2).base(b).haveprevconcussion        = T1{ r, 244 }; % "Yes", "No", or blank
   sub(s2).base(b).prevconcussion            = T1{ r, 246 }; % Note in CARE 2.0, column 246 (concussion count) doesn't match 245 by 479 concussions
   

   sub(s2).base(b).menningitis        = T1{ r, 381 };
   sub(s2).base(b).seizdis            = T1{ r, 382 };
   sub(s2).base(b).diabetes           = T1{ r, 383 };
   sub(s2).base(b).sleepdis           = T1{ r, 385 };
   sub(s2).base(b).balancedisorder    = T1{ r, 386 };
   sub(s2).base(b).vestibulardisorder = T1{ r, 387 };
   sub(s2).base(b).vertigo            = T1{ r, 388 };
   sub(s2).base(b).motionsickness     = T1{ r, 389 };
   
   sub(s2).base(b).menieresdisease          = T1{ r, 390 };
   sub(s2).base(b).balancedisorderother     = T1{ r, 391 };
   sub(s2).base(b).balancedisorderothertxt  = T1{ r, 392 };
   sub(s2).base(b).psydis                   = T1{ r, 393 };
   sub(s2).base(b).psydusdxunk              = T1{ r, 394 };
   sub(s2).base(b).psydisdxmood             = T1{ r, 395 };
   
   sub(s2).base(b).psydisdxanxdis           = T1{ r, 396 };
   sub(s2).base(b).psydisdxptsd             = T1{ r, 397 };
   sub(s2).base(b).psydisdxsoma             = T1{ r, 398 };
   sub(s2).base(b).psydisdxalcabuse         = T1{ r, 399 };
   sub(s2).base(b).psydisdxdrugabuse        = T1{ r, 400 };
   sub(s2).base(b).psydisdxpersonality      = T1{ r, 401 };
   
   
   sub(s2).base(b).psydisdxpsychotic         = T1{ r, 402 };
   sub(s2).base(b).psydisdxother             = T1{ r, 403 };
   sub(s2).base(b).psydisdxlearndis          = T1{ r, 404 };
   sub(s2).base(b).addadhd                   = T1{ r, 405 };
   sub(s2).base(b).autspect                  = T1{ r, 406 };
   sub(s2).base(b).depression                = T1{ r, 407 };
   sub(s2).base(b).bipolar                   = T1{ r, 408 };
   sub(s2).base(b).schizophrenia             = T1{ r, 409 };
   sub(s2).base(b).modsevtbi                 = T1{ r, 410 };
   sub(s2).base(b).brainsurgery              = T1{ r, 411 };
   sub(s2).base(b).visprob                   = T1{ r, 412 };
   sub(s2).base(b).hearprob                  = T1{ r, 413 };
   sub(s2).base(b).stroke                    = T1{ r, 414 };
   sub(s2).base(b).parkinsons                = T1{ r, 415 };
   sub(s2).base(b).memory                    = T1{ r, 416 };
   sub(s2).base(b).alzheimers                = T1{ r, 417 };
   sub(s2).base(b).nonalzheimers             = T1{ r, 418 };
   sub(s2).base(b).mildcogimpariment         = T1{ r, 419 };
   sub(s2).base(b).nonmigha                  = T1{ r, 420 };
   sub(s2).base(b).migraine                  = T1{ r, 425 };

   sub(s2).base(b).sleephoursweek               = T1{ r, 489 };
   sub(s2).base(b).sleephoursweekend            = T1{ r, 490 };
   sub(s2).base(b).currentrx                    = T1{ r, 497 };
   %sub(s2).base(b).prescripmedsnone             = T1{ r, 373 }; % Not in CARE 2.0
   sub(s2).base(b).prescripmedsallergy          = T1{ r, 498 };
   sub(s2).base(b).prescripmedasthma            = T1{ r, 499 };
   
   sub(s2).base(b).prescripmedbirthcontrol      = T1{ r, 500 };
   sub(s2).base(b).prescripmedacidreflux        = T1{ r, 501 };
   sub(s2).base(b).prescripmedantidepressants   = T1{ r, 502 };
   sub(s2).base(b).prescripmedantianxiety       = T1{ r, 503 };
   sub(s2).base(b).prescripmedantipsychotic     = T1{ r, 504 };
   sub(s2).base(b).prescripmednarcoticpain      = T1{ r, 505 };
   sub(s2).base(b).prescripmednonnarcoticpain   = T1{ r, 506 };
   sub(s2).base(b).prescripmedssleepsedative    = T1{ r, 507 };
   sub(s2).base(b).prescripmedspsychostimulant  = T1{ r, 508 };
   sub(s2).base(b).prescripmedsother            = T1{ r, 509 };
   %sub(s2).base(b).prescripmedothertxt          = T1{ r, 386 }; % Not inCARE 2.0
   sub(s2).base(b).currrxnames                  = T1{ r, 510 };
   sub(s2).base(b).nonprescriptmed              = T1{ r, 511 };
   
   sub(s2).base(b).otcibuprofen              = T1{ r, 512 };
   sub(s2).base(b).otcacetamin               = T1{ r, 513 };
   sub(s2).base(b).otcallergymed             = T1{ r, 514 };
   sub(s2).base(b).otcmedsorsipsother        = T1{ r, 515 };
   
   sub(s2).base(b).smokemonth                 = T1{ r, 527 };
   sub(s2).base(b).cigsperwk                  = T1{ r, 528 };
   sub(s2).base(b).tobaccocansdipperwk        = T1{ r, 529 };
   sub(s2).base(b).marijuanausemonth          = T1{ r, 530 };
   sub(s2).base(b).marijuanaweeklyamountused  = T1{ r, 531 };
   sub(s2).base(b).marijuanaunit              = T1{ r, 532 };
   sub(s2).base(b).etohcombined               = T1{ r, 541 };
   sub(s2).base(b).daysperweekdrink           = T1{ r, 542 };
   sub(s2).base(b).avgnumberdrinks            = T1{ r, 543 };
   
   
   sub(s2).base(b).bsscompletestatus         = T1{ r, 544};
   sub(s2).base(b).bssdt                     = T1{ r, 547 };
   sub(s2).base(b).bsssexplorestrangeplaces  = T1{ r, 551 };
   sub(s2).base(b).bsssrestlessathome        = T1{ r, 552 };
   sub(s2).base(b).bsssfrighteningthings     = T1{ r, 553 };
   sub(s2).base(b).bssswildparties           = T1{ r, 554 };
   sub(s2).base(b).bssstripnoplans           = T1{ r, 555 };
   sub(s2).base(b).bsssunpredfriends         = T1{ r, 556 };
   sub(s2).base(b).bsssbungeejumping         = T1{ r, 557 };
   sub(s2).base(b).bsssnewillegalexp         = T1{ r, 558 };
   sub(s2).base(b).bsss_score                = T1{ r, 559 };
      
   sub(s2).base(b).incometotalhouseinc       = T1{ r, 565 };
   sub(s2).base(b).mothedu                   = T1{ r, 566 };
   sub(s2).base(b).mothocc                   = T1{ r, 567 };
   sub(s2).base(b).fathedu                   = T1{ r, 568 };
   sub(s2).base(b).fathocc                   = T1{ r, 569 };

   sub(s2).base(b).scat3completestatus       = T1{ r, 571 };
   sub(s2).base(b).scatha                    = T1{ r, 579 };
   sub(s2).base(b).scatpresshead             = T1{ r, 580 };
   sub(s2).base(b).scatneckpain              = T1{ r, 581 };
   sub(s2).base(b).scatnausea                = T1{ r, 582 };
   sub(s2).base(b).scatdizz                  = T1{ r, 583 };
   
   sub(s2).base(b).scatblvis                 = T1{ r, 584 };
   sub(s2).base(b).scatbalprob               = T1{ r, 585 };
   sub(s2).base(b).scatsenslight             = T1{ r, 586 };
   sub(s2).base(b).scatsensnois              = T1{ r, 587 };
   sub(s2).base(b).scatfeelslow              = T1{ r, 588 };
   sub(s2).base(b).scatfog                   = T1{ r, 589 };
   sub(s2).base(b).scatdontfeel              = T1{ r, 590 };
   sub(s2).base(b).scatdiffconc              = T1{ r, 591 };
   sub(s2).base(b).scatdiffrem               = T1{ r, 592 };
   sub(s2).base(b).scatfatigue               = T1{ r, 593 };
   sub(s2).base(b).scatconf                  = T1{ r, 594 };
   sub(s2).base(b).scatdrowsiness            = T1{ r, 595 };
   sub(s2).base(b).scattrfallsleep           = T1{ r, 596 };
   sub(s2).base(b).scatemotional             = T1{ r, 597 };
   sub(s2).base(b).scatirritable             = T1{ r, 598 };
   sub(s2).base(b).scatsad                   = T1{ r, 599 };
   sub(s2).base(b).scatnervanx               = T1{ r, 600 };
   sub(s2).base(b).scattotnumsx_score        = T1{ r, 601 };
   sub(s2).base(b).scatsxsev_score           = T1{ r, 602 };
   sub(s2).base(b).sleeplastnight            = T1{ r, 603 };
   sub(s2).base(b).scatpisxphys              = T1{ r, 604 };
   sub(s2).base(b).scatpisxment              = T1{ r, 605 };
   sub(s2).base(b).scat3noncompreason        = T1{ r, 572 };
   sub(s2).base(b).scat3noncompreasonothertxt= T1{ r, 573 };
   
   
   sub(s2).base(b).bsi18completestatus       = T1{ r, 608 };
   sub(s2).base(b).bsifaint                  = T1{ r, 616 };
   sub(s2).base(b).bsiinterest               = T1{ r, 617 };
   sub(s2).base(b).bsinervous                = T1{ r, 618 };
   sub(s2).base(b).bsichestpain              = T1{ r, 619 };
   sub(s2).base(b).bsilonely                 = T1{ r, 620 };
   sub(s2).base(b).bsiintense                = T1{ r, 621 };    %sub(s2).base(b).bsitense  
   sub(s2).base(b).bsinausea                 = T1{ r, 622 };
   sub(s2).base(b).bsiblue                   = T1{ r, 623 };
   sub(s2).base(b).bsiscared                 = T1{ r, 624 }; 
   sub(s2).base(b).bsibreath                 = T1{ r, 625 };
   sub(s2).base(b).bsiworth                  = T1{ r, 626 };
   sub(s2).base(b).bsipanic                  = T1{ r, 627 };
   sub(s2).base(b).bsinumb                   = T1{ r, 628 };
   sub(s2).base(b).bsihopeless               = T1{ r, 629 };
   sub(s2).base(b).bsirestless               = T1{ r, 630 };
   sub(s2).base(b).bsiweak                   = T1{ r, 631 };
   sub(s2).base(b).bsiendlife                = T1{ r, 632 };
   sub(s2).base(b).bsifearful                = T1{ r, 633 }; 
   sub(s2).base(b).bsisomerawscore           = T1{ r, 634 };
   sub(s2).base(b).bsideprawscore            = T1{ r, 635 };
   sub(s2).base(b).bsianxrawscore            = T1{ r, 636 };
   sub(s2).base(b).bsigsiscore               = T1{ r, 637 };
   sub(s2).base(b).bsi18noncompreason        = T1{ r, 609 };
   
   sub(s2).base(b).wtarraw_score             = T1{ r, 780 };
   sub(s2).base(b).wtarstandard_score        = T1{ r, 781 };
   sub(s2).base(b).wtarcompletestatus        = T1{ r, 723 };
   
   sub(s2).base(b).impactvalid               = T1{ r, 793 };
   sub(s2).base(b).imvermsco                 = T1{ r, 794 };
   sub(s2).base(b).imvismsco                 = T1{ r, 795 };
   sub(s2).base(b).imvmssco                  = T1{ r, 796 };
   sub(s2).base(b).imrtsco                   = T1{ r, 797 }; 
   sub(s2).base(b).imimpsco                  = T1{ r, 798 };
   sub(s2).base(b).imsympsev                 = T1{ r, 799 };
   sub(s2).base(b).imcogeffindex             = T1{ r, 800 };
   
   sub(s2).base(b).sactestdt                 = T1{ r, 643 };
   sub(s2).base(b).sacstarttime              = T1{ r, 644 };
   sub(s2).base(b).sacendtime                = T1{ r, 645 };
   sub(s2).base(b).scaccompletestatus        = T1{ r, 640 };
   sub(s2).base(b).sacmonth                  = T1{ r, 647 };
   sub(s2).base(b).sacyear                   = T1{ r, 649 };
   sub(s2).base(b).sacdaywk                  = T1{ r, 650 };
   sub(s2).base(b).sactime                   = T1{ r, 651 };
   sub(s2).base(b).sact1w1                   = T1{ r, 652 };
   sub(s2).base(b).sact1w2                   = T1{ r, 653 };
   sub(s2).base(b).sact1w3                   = T1{ r, 654 };
   sub(s2).base(b).sact1w4                   = T1{ r, 655 };
   sub(s2).base(b).sact1w5                   = T1{ r, 656 };
   sub(s2).base(b).sact2w1                   = T1{ r, 657 };
   sub(s2).base(b).sact2w2                   = T1{ r, 658 };
   sub(s2).base(b).sact2w3                   = T1{ r, 659 };
   sub(s2).base(b).sact2w4                   = T1{ r, 660 };
   sub(s2).base(b).sact2w5                   = T1{ r, 661 };
   sub(s2).base(b).sact3w1                   = T1{ r, 662 };
   sub(s2).base(b).sact3w2                   = T1{ r, 663 };
   sub(s2).base(b).sact3w3                   = T1{ r, 664 };
   sub(s2).base(b).sact3w4                   = T1{ r, 665 };
   sub(s2).base(b).sact3w5                   = T1{ r, 666 };
   sub(s2).base(b).sacim_trial1              = T1{ r, 667 };
   sub(s2).base(b).sacim_trial2              = T1{ r, 668 };
   sub(s2).base(b).sacim_trial3              = T1{ r, 669 };
   sub(s2).base(b).sacconc3dgt               = T1{ r, 670 };
   sub(s2).base(b).sacconc4dgt               = T1{ r, 671 };
   sub(s2).base(b).sacconc5dgt               = T1{ r, 672 };
   sub(s2).base(b).sacconc6dgt               = T1{ r, 673 };
   sub(s2).base(b).sacrevmonths              = T1{ r, 674 };
   sub(s2).base(b).sacdelrecww1              = T1{ r, 676 };
   sub(s2).base(b).sacdelrecww2              = T1{ r, 677 };
   sub(s2).base(b).sacdelrecww3              = T1{ r, 678 };
   sub(s2).base(b).sacdelrecww4              = T1{ r, 679 };
   sub(s2).base(b).sacdelrecww5              = T1{ r, 680 };
   sub(s2).base(b).sac_orientationscore      = T1{ r, 697 };
   sub(s2).base(b).sac_immediatememscore     = T1{ r, 694 };
   sub(s2).base(b).sac_concentrationscore    = T1{ r, 695 };
   sub(s2).base(b).sac_delayedscore          = T1{ r, 688 };
   sub(s2).base(b).sac_totalscore            = T1{ r, 700 };
   sub(s2).base(b).sacnoncompreason          = T1{ r, 641 };
   sub(s2).base(b).sacnoncompreasonothertxt  = T1{ r, 642 };
   
% START HERE AT BESS, plus fill in some things above

   sub(s2).base(b).bessdt                    = T1{ r, 705 };
   sub(s2).base(b).bessstarttime             = T1{ r, 706 };
   sub(s2).base(b).besscompletestatus        = T1{ r, 702 };
   sub(s2).base(b).bessnondomfoot            = T1{ r, 709 };
   sub(s2).base(b).bessathlworesocks         = T1{ r, 710 };
   sub(s2).base(b).bessfirmdl                = T1{ r, 711 };
   sub(s2).base(b).bessfirmsl                = T1{ r, 712 };
   sub(s2).base(b).bessfirmtan               = T1{ r, 713 };
   sub(s2).base(b).bessfoamdl                = T1{ r, 714 };
   sub(s2).base(b).bessfoamsurfacenotcom     = T1{ r, 715 }; 
   sub(s2).base(b).bessfoamsl                = T1{ r, 716 };
   sub(s2).base(b).bessfoamtan               = T1{ r, 717 };
   sub(s2).base(b).bess_firmscore            = T1{ r, 718 };
   sub(s2).base(b).bess_foamscore            = T1{ r, 719 };
   sub(s2).base(b).bess_totalscore           = T1{ r, 720 };
   sub(s2).base(b).besscomments              = T1{ r, 721 };
   sub(s2).base(b).bessnoncompreason         = T1{ r, 703 };
   sub(s2).base(b).bessnoncompreasonothertxt = T1{ r, 704 };
   
   
   
   
   
   % For Lauren to ADD
   % 1) Socio-Economic upt column 426 - done
   % 2) Add SCAT symptoms upto column 459 -done
   % 3) Add BSI 18 upto column 486 - done
   % 4) Add WTR column 551-553 - done
   % 5) Add ImPACT 561-568 - done
   
   % NOTE WE STILL NEED TO ADD SAC AND BESS
      
      

      


      
      
   % Sex
   
   if strcmp( T1{r,20}, 'F')
      sub(s2).base(b).sex = 1;
   elseif strcmp( T1{r,20}, 'M')
      sub(s2).base(b).sex = 2;
   elseif strcmp( T1{r,20}, 'NA') % We believe this is Not Available, rather than intersex ???
      %disp(r)
      sub(s2).base(b).sex = 4;
   end %if
   

   
   sub(s2).base(b).n_injury   = 0;
    
   
   %for i = 1:5
   %   sub(s2).base(b).inj(i).n_good_tp  = 0;
   %   for tp = 1:13
   %      sub(s2).base(b).inj(i).tp(tp).voms = 0;        
   %   end
   %end
   
end %for  r % row

%clear s i


% Make a list of my subject numbers
for s = 1:length(sub)
 my_subid_list(s)=sub(s).sub_id;
end

% Now read in the post injuries

 disp('Read table 2');
 T2 = readtable('../CARE_20/CARE_postinjury_assessments_NoControls_2021_09_29_data_ran_2021_10_05.csv'              );
 %T2 = readtable('../CARE_1Full_Feb23_Files/CARE1Full_postinjury_assessments_23FEB2021_data_ran_26FEB2021.csv'     );
      
%
clear s

for r = 1:size(T2,1)
   
   %if ~strcmp(T2{r,9}{1},'Base')
   if T2{r,13} > 1
      
      s = find(my_subid_list == T2{r,2});
      
      i_id = T2{r,7};      % injuryid
      
      j = find( sub(s).injury_id == i_id );
      
      if isempty(j)                                         %new injury
         sub(s).n_injuries = sub(s).n_injuries + 1;
         ni = sub(s).n_injuries;
         
         sub(s).injury_id(ni) = T2{r,7};
         
         tp = T2{r,13}; % Grab the Time Point Index
         
      else sub(s).injury_id(j) ==  T2{r,7};      % injuryid  - this means same injury & new time point
         tp = T2{r,13}; % Grab the new Time Point Index
         
      end
         
      sub(s).injury(ni).time_p(tp).injurydt             = T2{r, 8  };
      %sub(s).injury(ni).time_p(tp).injsituation         = T2{r, 12  }; Not % in 2.0
      
      sub(s).injury(ni).time_p(tp).testdt               = T2{r, 17 };
      sub(s).injury(ni).time_p(tp).bsi18completestatus  = T2{r, 42 };
      

      
      
      sub(s).injury(ni).time_p(tp).bessid               = T2{r, 18  };
      sub(s).injury(ni).time_p(tp).bessdt               = T2{r, 22 };
      sub(s).injury(ni).time_p(tp).bessstarttime        = T2{r, 23 };
      sub(s).injury(ni).time_p(tp).bessnondomfoot       = T2{r, 28 };
      sub(s).injury(ni).time_p(tp).bessathlworesocks    = T2{r, 29 };
      sub(s).injury(ni).time_p(tp).bessfirmdl           = T2{r, 31 };
      sub(s).injury(ni).time_p(tp).bessfirmsl           = T2{r, 32 };
      sub(s).injury(ni).time_p(tp).bessfirmtan          = T2{r, 33 };
      sub(s).injury(ni).time_p(tp).bessfoamdl           = T2{r, 34 };
      sub(s).injury(ni).time_p(tp).bessfoamsl           = T2{r, 35 };
      sub(s).injury(ni).time_p(tp).bessfoamtan          = T2{r, 36 };
      sub(s).injury(ni).time_p(tp).bess_firmscore       = T2{r, 37 };
      sub(s).injury(ni).time_p(tp).bess_foamscore       = T2{r, 38 };
      sub(s).injury(ni).time_p(tp).bess_totalscore      = T2{r, 39 };
      sub(s).injury(ni).time_p(tp).besscompletestatus   = T2{r, 19 };
      sub(s).injury(ni).time_p(tp).bessnoncompreason    = T2{r, 20 };
      
      sub(s).injury(ni).time_p(tp).bessnoncompreasonothertxt  = T2{r, 21};
     
      sub(s).injury(ni).time_p(tp).besscomments         = T2{r, 40 }; 
      
      
      
      
      sub(s).injury(ni).time_p(tp).bsi18id             = T2{r, 41  };
      sub(s).injury(ni).time_p(tp).bsidt               = T2{r, 45 };
      sub(s).injury(ni).time_p(tp).bsi18directentry    = T2{r, 50 };
      sub(s).injury(ni).time_p(tp).bsistarttime        = T2{r, 46 };
      sub(s).injury(ni).time_p(tp).bsiendtime          = T2{r, 47 };
      sub(s).injury(ni).time_p(tp).bsi18noncompreason  = T2{r, 43 };
      sub(s).injury(ni).time_p(tp).bsisomrawscore      = T2{r, 73 };
      sub(s).injury(ni).time_p(tp).bsianxrawscore      = T2{r, 72 };
      sub(s).injury(ni).time_p(tp).bsideprawscore      = T2{r, 71 };
      sub(s).injury(ni).time_p(tp).bsigsiscore         = T2{r, 70 };
      sub(s).injury(ni).time_p(tp).bsiblue             = T2{r, 59 };
      sub(s).injury(ni).time_p(tp).bsibreath           = T2{r, 61 };
      sub(s).injury(ni).time_p(tp).bsichestpain        = T2{r, 55 };
      sub(s).injury(ni).time_p(tp).bsiendlife          = T2{r, 68 };
      sub(s).injury(ni).time_p(tp).bsifaint            = T2{r, 52 };
      sub(s).injury(ni).time_p(tp).bsifearful          = T2{r, 69 };
      sub(s).injury(ni).time_p(tp).bsihopeless         = T2{r, 65 };
      sub(s).injury(ni).time_p(tp).bsiinterest         = T2{r, 53 };
      sub(s).injury(ni).time_p(tp).bsilonely           = T2{r, 56 };
      sub(s).injury(ni).time_p(tp).bsinausea           = T2{r, 58 };
      sub(s).injury(ni).time_p(tp).bsinervous          = T2{r, 54 };
      sub(s).injury(ni).time_p(tp).bsinumb             = T2{r, 64 };
      sub(s).injury(ni).time_p(tp).bsipanic            = T2{r, 63 };
      sub(s).injury(ni).time_p(tp).bsirestless         = T2{r, 66 };
      sub(s).injury(ni).time_p(tp).bsiscared           = T2{r, 60 };
      sub(s).injury(ni).time_p(tp).bsiintense          = T2{r, 57 };
      sub(s).injury(ni).time_p(tp).bsiweak             = T2{r, 67 };
      sub(s).injury(ni).time_p(tp).bsiworth            = T2{r, 62 };
      
      sub(s).injury(ni).time_p(tp).sacid               = T2{r, 75  };
      sub(s).injury(ni).time_p(tp).sactestdt           = T2{r, 79 };
      sub(s).injury(ni).time_p(tp).sacstarttime        = T2{r, 80 };
      sub(s).injury(ni).time_p(tp).sacendtime          = T2{r, 81 };
      sub(s).injury(ni).time_p(tp).sacdirectentry      = T2{r, 84 };
      sub(s).injury(ni).time_p(tp).saccompletestatus   = T2{r, 76 };
      sub(s).injury(ni).time_p(tp).sacnoncompreason    = T2{r, 77 };
      
      sub(s).injury(ni).time_p(tp).sacnoncompreasonothertxt = T2{r, 78 };
     
      sub(s).injury(ni).time_p(tp).sacexertman          = T2{r, 118};
      sub(s).injury(ni).time_p(tp).sacim_trial1         = T2{r, 95 };
      sub(s).injury(ni).time_p(tp).sacim_trial2         = T2{r, 101};
      sub(s).injury(ni).time_p(tp).sacim_trial3         = T2{r, 107};
      sub(s).injury(ni).time_p(tp).sacmonth             = T2{r, 85 };
      sub(s).injury(ni).time_p(tp).sactime              = T2{r, 89 };
      sub(s).injury(ni).time_p(tp).sacyear              = T2{r, 88 };
      sub(s).injury(ni).time_p(tp).sacneuronotdone      = T2{r, 111};
      sub(s).injury(ni).time_p(tp).sacrevmonths         = T2{r, 117};
      sub(s).injury(ni).time_p(tp).sacsensasses         = T2{r, 109};
      sub(s).injury(ni).time_p(tp).sacstrnthdescasses   = T2{r, 108};
      sub(s).injury(ni).time_p(tp).sacconc3dgt          = T2{r, 113};
      sub(s).injury(ni).time_p(tp).sacconc4dgt          = T2{r, 114};
      sub(s).injury(ni).time_p(tp).sacconc5dgt          = T2{r, 115};
      sub(s).injury(ni).time_p(tp).sacconc6dgt          = T2{r, 116};
      sub(s).injury(ni).time_p(tp).saccoordasses        = T2{r, 110};
      sub(s).injury(ni).time_p(tp).sacdaywk             = T2{r, 87 };
      sub(s).injury(ni).time_p(tp).sacdelrecww1         = T2{r, 119};
      sub(s).injury(ni).time_p(tp).sacdelrecww2         = T2{r, 120};
      sub(s).injury(ni).time_p(tp).sacdelrecww3         = T2{r, 121};
      sub(s).injury(ni).time_p(tp).sacdelrecww4         = T2{r, 122};
      sub(s).injury(ni).time_p(tp).sacdelrecww5         = T2{r, 123};
      sub(s).injury(ni).time_p(tp).sact1w1              = T2{r, 90 };
      sub(s).injury(ni).time_p(tp).sact1w2              = T2{r, 91 };
      sub(s).injury(ni).time_p(tp).sact1w3              = T2{r, 92 };
      sub(s).injury(ni).time_p(tp).sact1w4              = T2{r, 93 };
      sub(s).injury(ni).time_p(tp).sact1w5              = T2{r, 94 };
      sub(s).injury(ni).time_p(tp).sact2w1              = T2{r, 96 };
      sub(s).injury(ni).time_p(tp).sact2w2              = T2{r, 97 };
      
      sub(s).injury(ni).time_p(tp).sact2w3              = T2{r, 98 };
      sub(s).injury(ni).time_p(tp).sact2w4              = T2{r, 99 };
      sub(s).injury(ni).time_p(tp).sact2w5              = T2{r, 100 };
      sub(s).injury(ni).time_p(tp).sact3w1              = T2{r, 102 };
      sub(s).injury(ni).time_p(tp).sact3w2              = T2{r, 103 };
      sub(s).injury(ni).time_p(tp).sact3w3              = T2{r, 104 };
      sub(s).injury(ni).time_p(tp).sact3w4              = T2{r, 105 };
      sub(s).injury(ni).time_p(tp).sact3w5              = T2{r, 106 };
      
      sub(s).injury(ni).time_p(tp).sac_concentrationscore     = T2{r, 136 };
      sub(s).injury(ni).time_p(tp).sac_delayedscore           = T2{r, 137 };
      sub(s).injury(ni).time_p(tp).sac_immediatememscore      = T2{r, 135 };
      sub(s).injury(ni).time_p(tp).sac_orientationscore       = T2{r, 134 };
      sub(s).injury(ni).time_p(tp).sac_totalscore             = T2{r, 138 };
      
      sub(s).injury(ni).time_p(tp).scat3id                = T2{r, 139 };
      sub(s).injury(ni).time_p(tp).scattexamd             = T2{r, 143 };
      sub(s).injury(ni).time_p(tp).scatstarttime          = T2{r, 144 };
      sub(s).injury(ni).time_p(tp).scatendtime            = T2{r, 145 };
      sub(s).injury(ni).time_p(tp).scat3completestatus    = T2{r, 140 };
      sub(s).injury(ni).time_p(tp).scatnoncompreason      = T2{r, 141 };
      
      sub(s).injury(ni).time_p(tp).scatnoncompreasonothertxt  = T2{r, 142 };
     
      sub(s).injury(ni).time_p(tp).scatdirectentry        = T2{r, 148 };
      sub(s).injury(ni).time_p(tp).scatbalprob            = T2{r, 156 };
      sub(s).injury(ni).time_p(tp).scatblvis              = T2{r, 155 };
      sub(s).injury(ni).time_p(tp).scatconf               = T2{r, 165 };
      sub(s).injury(ni).time_p(tp).scatdiffconc           = T2{r, 162 };
      sub(s).injury(ni).time_p(tp).scatdiffrem            = T2{r, 163 };
      sub(s).injury(ni).time_p(tp).scatdizz               = T2{r, 154 };
      sub(s).injury(ni).time_p(tp).scatdontfeel           = T2{r, 161 };
      sub(s).injury(ni).time_p(tp).scattrfallsleep        = T2{r, 167 };
      sub(s).injury(ni).time_p(tp).scatdrowiness          = T2{r, 166 };
      sub(s).injury(ni).time_p(tp).scatemotional          = T2{r, 168 };
      sub(s).injury(ni).time_p(tp).scatgfatigue           = T2{r, 164 };
      sub(s).injury(ni).time_p(tp).scatfeelslow           = T2{r, 159 };
      sub(s).injury(ni).time_p(tp).scatfog                = T2{r, 160 };
      sub(s).injury(ni).time_p(tp).scatha                 = T2{r, 150 };
      sub(s).injury(ni).time_p(tp).scatirritable          = T2{r, 169 };
      sub(s).injury(ni).time_p(tp).scatnausea             = T2{r, 153 };
      sub(s).injury(ni).time_p(tp).scatneckpain           = T2{r, 152 };
      sub(s).injury(ni).time_p(tp).scatnervanx            = T2{r, 173 };
      sub(s).injury(ni).time_p(tp).scatpisxment           = T2{r, 176 };
      sub(s).injury(ni).time_p(tp).scatpisxphys           = T2{r, 175 };
      sub(s).injury(ni).time_p(tp).scatpresshead          = T2{r, 151 };
      sub(s).injury(ni).time_p(tp).scatsad                = T2{r, 170 };
      sub(s).injury(ni).time_p(tp).scatsenslight          = T2{r, 157 };
      sub(s).injury(ni).time_p(tp).scatsensnois           = T2{r, 158 };
      sub(s).injury(ni).time_p(tp).scatsxsev_score        = T2{r, 172 };
      sub(s).injury(ni).time_p(tp).scattotnumsx_score     = T2{r, 171 };
      sub(s).injury(ni).time_p(tp).sleeplastnight         = T2{r, 174 };
      
      sub(s).injury(ni).time_p(tp).impactvalid            = T2{r, 238 };
      sub(s).injury(ni).time_p(tp).impacttestdt           = T2{r, 239 };
      sub(s).injury(ni).time_p(tp).imimpsco               = T2{r, 246 };
      sub(s).injury(ni).time_p(tp).imrtsco                = T2{r, 245 };
      sub(s).injury(ni).time_p(tp).imsympsev              = T2{r, 247 };
      sub(s).injury(ni).time_p(tp).imvermsco              = T2{r, 242 };
      sub(s).injury(ni).time_p(tp).imvismsco              = T2{r, 243 };
      sub(s).injury(ni).time_p(tp).imvmssco               = T2{r, 244 };
      sub(s).injury(ni).time_p(tp).imcogeffindex          = T2{r, 248 };
      
      
      
            
      
   end % time point > 1
   
end %for r
   
% Now import some key items from the third file

%clear T1 T2

disp('Read table 3');
T3 = readtable('../CARE_20/CARE_Injuries_NoControls_2021_09_29_data_ran_2021_10_05.csv'              );
%T3 = readtable('../CARE_1Full_Feb23_Files/CARE1Full_Injuries_23FEB2021_data_ran_26FEB2021.csv'     );

clear s

debug_list = [];  % There are subjects in T3 which do not have injury data in T2
debug_i = 0;

for r = 1:size(T3,1)
   
   s  = find(my_subid_list == T3{r,4});
   ii = find(sub(s).injury_id == T3{r,6});
   
   if ~isempty(ii)


      sub(s).injury(ii).sport                     = T3{r,14};
      sub(s).injury(ii).injsituation              = T3{r,18};

      sub(s).injury(ii).days_reported_late        = T3{r,46};

      sub(s).injury(ii).report_injury_immediately = T3{r,58};
      sub(s).injury(ii).report_injury_date        = T3{r,59};
      sub(s).injury(ii).report_injury_immed_time  = T3{r,60};


      sub(s).injury(ii).delaysx        = T3{r,108}{1}; % Was 87, but should probably be 86
      sub(s).injury(ii).return_same_day= T3{r,111};
      sub(s).injury(ii).almentalstatus = T3{r,112};
      sub(s).injury(ii).loc            = T3{r,113};
      sub(s).injury(ii).pta            = T3{r,117};
      sub(s).injury(ii).rga            = T3{r,120};

      % Medications at the time of injury
      sub(s).injury(ii).rx_inj             = T3{r,256}; 
      
      % Need to confirm the coding system, 8 might be birth control, 7 might be Psycho-stimulant
      % sub(s).injury(ii).inj_rx_type        = T3{r,114};  % Old column in CARE 1.0
      sub(s).injury(ii).InjRxPsychoStim      = T3{r,274};  % New column in CARE 2.0
      
      % Need to input every type

      sub(s).injury(ii).inj_rx_type_oth    = T3{r,280};
      sub(s).injury(ii).otc_inj            = T3{r,262};


      sub(s).injury(ii).time_toasympt_days              = T3{r,152};
      sub(s).injury(ii).time_toasympy_days_original     = T3{r,153};
      sub(s).injury(ii).time_tortp_days                 = T3{r,181};
      sub(s).injury(ii).time_tortp_days_original        = T3{r,182};
   else
      % SAVE - SEE DEBUG NOTES BELOW
      %disp(sub(s).sub_id)
      %debug_i = debug_i + 1;
      %debug_list(debug_i) = sub(s).sub_id;
   end

   
end %for r
   


T2_subid = T2{:,2};

% Check the debug_list - every thing should be 'Base' only
% This is what happened - all are Base
% This means the extra 'injuries' in T3 have no useable data in T2.
% We are going to move on and not worry about these 17 subjects.
% SAVE THIS CODE FOR THE FUTURE - May 24, 2021

% %
% for i = 1:length(debug_list)
%    
%    ii = find(T2_subid == debug_list(1));
%    for j = 1:length(ii)
%       T2{ii(j),9}
%    end
% end
















% fini