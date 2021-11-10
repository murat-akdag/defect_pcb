function []=defectpcb(img1,img2)
img1=imread('x.png');
img2=imread('xbzk.png');
res=img2;
kontrol=0;
subplot(1,2,1),imshow(img1),title('Orjinal Resim');
subplot(1,2,2),imshow(img2),title('Hatalı Resim');
img1=img1*1.4;
img2=img2*1.4;

img1=rgb2gray(img1);
img2=rgb2gray(img2);
img1=medfilt2(img1);
img2=medfilt2(img2); 

h1=edge(img1,'canny');
h2=edge(img2,'canny');

m=fspecial('unsharp');
h1=img1+im2uint8(h1);
h2=img2+im2uint8(h2);

h1=imfilter(h1,m);
h2=imfilter(h2,m);

h1=imfill(h1,'hole');
h1=imfill(h1,'hole');
h1=imfill(h1,'hole');
h1=imfill(h1,'hole');
h2=imfill(h2,'hole');
h2=imfill(h2,'hole');
h2=imfill(h2,'hole');
h2=imfill(h2,'hole');
img1=h1>190;
img2=h2>190;
figure
subplot(1,2,1),imshow(img1),title('Orjinal Resim');
subplot(1,2,2),imshow(img2),title('Hatalı Resim');
figure
sonuc=xor(img1,img2);
sonuc = bwareaopen(sonuc,3);
imshow(sonuc);
sonuc=im2uint8(sonuc);
[x,y]=size(sonuc);

for i=1:x
    for j=1:y
     if sonuc(i,j)==255
         kontrol=1;
     end
    end
end

if kontrol==1
    disp('Devrede Hata Var');
else
    disp('Devrede Hata Yok');
end

r=res(:,:,1);
g=res(:,:,2);
b=res(:,:,3);
for i=1:x
    for j=1:y
     if sonuc(i,j)==255
         r(i,j)=255;
         g(i,j)=0;
         b(i,j)=0;
     end
    end
end
hata=cat(3,r,g,b);
figure
imshow(hata);

end