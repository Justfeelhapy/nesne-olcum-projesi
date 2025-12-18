function gui_butonlu_nesne_olc
clc; close all;

% Global degiskenler
global I coinScale objBox objWidth_cm objHeight_cm objDia_cm

I = [];
coinScale = [];
objBox = [];
objWidth_cm = [];
objHeight_cm = [];
objDia_cm = [];

refDia_cm = 2.615;   % 1 TL gerçek çapı (cm)

%% ANA GUI PENCERESI
fig = figure('Name','Nesne Cap Olcumu ',...
             'Position',[300 150 1000 600],...
             'NumberTitle','off',...
             'MenuBar','none');

axesHandle = axes('Parent',fig,'Units','pixels',...
                  'Position',[50 120 600 430]);
axis off;

%% BUTONLAR
uicontrol(fig,'Style','pushbutton','String','Resim Sec',...
    'Position',[720 480 220 40],'FontSize',11,...
    'Callback',@resimSec);

uicontrol(fig,'Style','pushbutton','String','1 TL Sec',...
    'Position',[720 420 220 40],'FontSize',11,...
    'Callback',@paraSec);

uicontrol(fig,'Style','pushbutton','String','Nesneyi Olc',...
    'Position',[720 360 220 40],'FontSize',11,...
    'Callback',@olcumYap);

uicontrol(fig,'Style','pushbutton','String','Sonucu Kaydet',...
    'Position',[720 300 220 40],'FontSize',11,...
    'Callback',@sonucKaydet);

%% BILGI ALANI
bilgiKutusu = uicontrol(fig,'Style','text',...
    'Position',[680 100 300 160],...
    'FontSize',11,'HorizontalAlignment','left');

%% ---------- BUTON FONKSIYONLARI ----------

    function resimSec(~,~)
        [file,path] = uigetfile({'*.jpg;*.png;*.jpeg;*.tif;*.bmp','Image Files (*.jpg,*.png,*.jpeg,*.tif,*.bmp)'},'Resim Sec');
        if isequal(file,0), return; end
        I = imread(fullfile(path,file));
        axes(axesHandle);
        imshow(I); title('Resim Yuklendi');
        set(bilgiKutusu,'String','Resim yuklendi.');
    end

    function paraSec(~,~)
        if isempty(I)
            errordlg('Once resim secmelisin!','Hata');
            return;
        end

        axes(axesHandle);
        imshow(I); hold on;
        title('1 TL merkezine, sonra kenarina tikla');

        [xc,yc] = ginput(1);
        plot(xc,yc,'ro','LineWidth',2);

        [xe,ye] = ginput(1);
        plot(xe,ye,'rx','LineWidth',2);
        line([xc xe],[yc ye],'Color','red','LineWidth',2);

        coinRadius_px = sqrt((xe-xc)^2+(ye-yc)^2);
        coinDia_px = 2*coinRadius_px;
        coinScale = refDia_cm/coinDia_px;

        set(bilgiKutusu,'String','1 TL secildi.');
        hold off;
    end

    function olcumYap(~,~)
        if isempty(coinScale)
            errordlg('Once 1 TL secmelisin!','Hata');
            return;
        end

        if isempty(I)
            errordlg('Once resim secmelisin!','Hata');
            return;
        end

        % Griye çevirme
        if size(I,3)==3
            gray = rgb2gray(I);
        else
            gray = I;
        end

        % Basit ön işlem (gerekirse ayarla)
        bw = imbinarize(gray);
        bw = imcomplement(bw);
        bw = bwareaopen(bw,1500);

        % Bölge tespiti
        [L,~] = bwlabel(bw);
        stats = regionprops(L,'Area','BoundingBox');

        if isempty(stats)
            errordlg('Herhangi bir nesne tespit edilemedi.','Hata');
            return;
        end

        areas = [stats.Area];
        [~,idx] = max(areas);
        objBox = stats(idx).BoundingBox;

        objWidth_px  = objBox(3);
        objHeight_px = objBox(4);

        objWidth_cm  = objWidth_px  * coinScale;
        objHeight_cm = objHeight_px * coinScale;

        objDia_px = sqrt(objWidth_px^2+objHeight_px^2);
        objDia_cm = objDia_px * coinScale;

        axes(axesHandle);
        imshow(I); hold on;
        rectangle('Position',objBox,'EdgeColor','g','LineWidth',2);

        % Bilgiyi göster
        txtX = max(1, objBox(1)-120);
        txtY = max(1, objBox(2)+20);
        text(txtX, txtY, ...
            sprintf('Gen: %.1f cm\nYuk: %.1f cm\nCap: %.1f cm',...
            objWidth_cm,objHeight_cm,objDia_cm),...
            'Color','yellow','FontWeight','bold','FontSize',11);

        set(bilgiKutusu,'String',sprintf(...
            'Gen: %.2f cm\nYuk: %.2f cm\nCap: %.2f cm',...
            objWidth_cm,objHeight_cm,objDia_cm));
        hold off;
    end

    function sonucKaydet(~,~)
        if isempty(objBox)
            errordlg('Once olcum yapmalisin!','Hata');
            return;
        end

        [file,path] = uiputfile('sonuc.png','Kaydet');
        if isequal(file,0), return; end

        F = getframe(axesHandle);
        imwrite(F.cdata,fullfile(path,file));

        msgbox('Sonuc basariyla kaydedildi.');
    end

end 
