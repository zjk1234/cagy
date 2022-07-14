% 
% testdata=xlsread('20190319144522.xlsx');
% time=testdata(:,1);
% acc=testdata(:,2);
% m1trq=testdata(:,16);
% m2trq=testdata(:,24);
% m3trq=testdata(:,32);
% m4trq=testdata(:,41);
% 
% figure(10)
% plot(time,acc,'r','linewidth',2);hold on;
% plot(time,m1trq,'b','linewidth',2);
% plot(time,m2trq,'k','linewidth',2);
% plot(time,m3trq,'y','linewidth',2);
% plot(time,m4trq,'g','linewidth',2);
% legend('加速','m1','m2','m3','m4');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% purpose 分析一下实车实验数据，看一下左转向不灵敏和车辆抖动是否和控制策略有关系
% data    2019年3月25日
% author  wxt
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;close all;
%%
[time,CANlineID,id,direction,unknown,datalength,bite1,bite2,bite3,bite4,bite5,bite6,bite7,bite8]=textread('2.asc','%f%d%s%s%s%d%s%s%s%s%s%s%s%s','headerlines',2);
% time1=char(time);
% time2=str2num(time1(:,1:2))*3600+str2num(time1(:,4:5))*60+str2num(time1(:,7:8))*1+str2num(time1(:,10:12))*0.001;  %时间单位统一，换成单位为s
% for i=2:length(time2)
% time_gap(i)=time2(i)-time2(1);
% end
% time_gap(1)=0;

id1=find(strcmp(id,'c01f001x'));

t1=time(id1);
m1trq_di=bite1(id1);m1trq_di_qu1=bitget(hex2dec(m1trq_di),8);m1trq_di_qu2=bitget(hex2dec(m1trq_di),7);
m1trq_zhong=bite2(id1);
m1trq_gao=bite3(id1);m1trq_gao_qu1=bitget(hex2dec(m1trq_gao),2);m1trq_gao_qu2=bitget(hex2dec(m1trq_gao),1);
m2trq_di=bite5(id1);m2trq_di_qu1=bitget(hex2dec(m2trq_di),8);m2trq_di_qu2=bitget(hex2dec(m2trq_di),7);m2trq_di_qu3=bitget(hex2dec(m2trq_di),6);m2trq_di_qu4=bitget(hex2dec(m2trq_di),5);
m2trq_gao=bite6(id1);

m1trq=(m1trq_gao_qu1*2^11+m1trq_gao_qu2*2^10+hex2dec(m1trq_zhong)*2^2+m1trq_di_qu1*2^1+m1trq_di_qu2)*0.25-300;
m2trq=(hex2dec(m2trq_gao)*2^4+m2trq_di_qu1*2^3+m2trq_di_qu2*2^2+m2trq_di_qu3*2^1+m2trq_di_qu4)*0.25-300;



id2=find(strcmp(id,'c01f002x'));

t2=time(id2);
m3trq_di=bite1(id2);m3trq_di_qu1=bitget(hex2dec(m3trq_di),8);m3trq_di_qu2=bitget(hex2dec(m3trq_di),7);
m3trq_zhong=bite2(id2);
m3trq_gao=bite3(id2);m3trq_gao_qu1=bitget(hex2dec(m3trq_gao),2);m3trq_gao_qu2=bitget(hex2dec(m3trq_gao),1);
m4trq_di=bite5(id2);m4trq_di_qu1=bitget(hex2dec(m4trq_di),8);m4trq_di_qu2=bitget(hex2dec(m4trq_di),7);m4trq_di_qu3=bitget(hex2dec(m4trq_di),6);m4trq_di_qu4=bitget(hex2dec(m4trq_di),5);
m4trq_gao=bite6(id2);

m3trq=(m3trq_gao_qu1*2^11+m3trq_gao_qu2*2^10+hex2dec(m3trq_zhong)*2^2+m3trq_di_qu1*2^1+m3trq_di_qu2)*0.25-300;
m4trq=(hex2dec(m4trq_gao)*2^4+m4trq_di_qu1*2^3+m4trq_di_qu2*2^2+m4trq_di_qu3*2^1+m4trq_di_qu4)*0.25-300;


id3=find(strcmp(id,'c01f022x'));

t3=time(id3);
mode=bitget(hex2dec(bite1(id3)),3)*2^2+bitget(hex2dec(bite1(id3)),2)*2^1+bitget(hex2dec(bite1(id3)),1);
acc=hex2dec(bite2(id3));
steer=hex2dec(bite3(id3));
brake=hex2dec(bite4(id3));




figure(10)
plot(t3,acc,'r','linewidth',2);hold on;
plot(t1,m1trq,'b','linewidth',2);
plot(t1,m2trq,'k','linewidth',2);
plot(t2,m3trq,'c','linewidth',2);
plot(t2,m4trq,'m','linewidth',2);
legend('acc','m1trq','m2trq','m3trq','m4trq');

figure(11)
% plot(t3,acc,'r','linewidth',2);
plot(t1,m1trq,'b','linewidth',2);hold on;
% plot(t1,m2trq,'k','linewidth',2);
plot(t2,m3trq,'c--','linewidth',2);
% plot(t2,m4trq,'m','linewidth',2);
legend('m1trq','m3trq');

figure(12)
% plot(t3,acc,'r','linewidth',2);
% plot(t1,m1trq,'b','linewidth',2);
plot(t1,m2trq,'k','linewidth',2);hold on;
% plot(t2,m3trq,'c','linewidth',2);
plot(t2,m4trq,'m--','linewidth',2);
legend('m2trq','m4trq');

figure(13)
% plot(t3,acc,'r','linewidth',2);
plot(t1,m1trq,'b','linewidth',2);hold on;
plot(t1,m2trq,'k','linewidth',2);
% plot(t2,m3trq,'c','linewidth',2);
% plot(t2,m4trq,'m--','linewidth',2);
legend('m1trq','m2trq');


% figure(13)
% plot(t1,m1trq-m3trq,'r','linewidth',2);
% legend('m1-m3');
% 
% figure(14)
% plot(t2,m2trq-m4trq,'r','linewidth',2);
% legend('m2-m4');


figure(20)
plot(t3,mode,'r','linewidth',2);
legend('mode');

figure(21)
plot(t3,acc,'r','linewidth',2);
legend('acc');

figure(22)
plot(t3,steer,'r','linewidth',2);
legend('steer');

figure(23)
plot(t3,brake,'r','linewidth',2);
legend('brake');

figure(24)
plot(t3,mode+50,'m','linewidth',2);hold on;
plot(t3,acc,'r','linewidth',2);
plot(t3,steer,'g','linewidth',2);
plot(t1,m1trq,'b','linewidth',2);
plot(t1,m2trq,'k','linewidth',2);
% plot(t2,m3trq,'c','linewidth',2);
% plot(t2,m4trq,'m--','linewidth',2);
legend('mode','acc','steer','m1trq','m2trq');
grid on;

%% 电机转速看一下
id4=find(strcmp(id,'b0101f0x'));

t4=time(id4);
m1spd=(hex2dec(bite6(id4))*2^8+hex2dec(bite5(id4)))*5-5000;

id5=find(strcmp(id,'b0301f0x'));

t5=time(id5);
m2spd=(hex2dec(bite6(id5))*2^8+hex2dec(bite5(id5)))*5-5000;

id6=find(strcmp(id,'b0102f0x'));

t6=time(id6);
m3spd=(hex2dec(bite6(id6))*2^8+hex2dec(bite5(id6)))*5-5000;

id7=find(strcmp(id,'b0302f0x'));

t7=time(id7);
m4spd=(hex2dec(bite6(id7))*2^8+hex2dec(bite5(id7)))*5-5000;

figure(30)
% plot(t3,acc,'r','linewidth',2);
plot(t4,m1spd,'b','linewidth',2);hold on;
plot(t5,m2spd,'k','linewidth',2);
plot(t6,m3spd,'c','linewidth',2);
plot(t7,m4spd,'m','linewidth',2);
legend('m1spd','m2spd','m3spd','m4spd');
%% 电机力矩限制看一下
id8=find(strcmp(id,'b0201f0x'));

t8=time(id8);
m1trqlim=(hex2dec(bite6(id8))*2^8+hex2dec(bite5(id8)))*0.125;

id9=find(strcmp(id,'b0401f0x'));

t9=time(id9);
m2trqlim=(hex2dec(bite6(id9))*2^8+hex2dec(bite5(id9)))*0.125;

id10=find(strcmp(id,'b0202f0x'));

t10=time(id10);
m3trqlim=(hex2dec(bite6(id10))*2^8+hex2dec(bite5(id10)))*0.125;

id11=find(strcmp(id,'b0402f0x'));

t11=time(id11);
m4trqlim=(hex2dec(bite6(id11))*2^8+hex2dec(bite5(id11)))*0.125;

figure(40)
% plot(t3,acc,'r','linewidth',2);
plot(t8,m1trqlim,'b','linewidth',2);hold on;
plot(t9,m2trqlim,'k','linewidth',2);
plot(t10,m3trqlim,'c','linewidth',2);
plot(t11,m4trqlim,'m','linewidth',2);
legend('m1trqlim','m2trqlim','m3trqlim','m4trqlim');




