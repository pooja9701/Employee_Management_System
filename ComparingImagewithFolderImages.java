// note both images same then return 0.0
// high differance means differnt images

import java.awt.Color;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
import java.io.File;
import java.io.IOException;
import java.util.*;

public class ComparingImagewithFolderImages
{
   public static String compareImage(String Folderpath,String Filepath)
   {
      /*  String Folderpath="c:\\attendance\\register\\";
        String Filepath="temp.jpg";*/

        File folder=new File(Folderpath);
        File file=new File(Filepath);

    	String n[]=folder.list();

         double avg =0;
         double percentage =0;
         boolean flag=false;

         double minper=25;
         String filename=null;


         BufferedImage img1=null;

        BufferedImage img2=null;

	    for(int k=0;k<n.length;k++)
       {
           String path=Folderpath+"\\"+n[k];

           try {
			img1 = ImageIO.read(new File(path));
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
           try {
			img2 = ImageIO.read(file);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

           int w1 = img1.getWidth();
           int w2 = img2.getWidth();
    	   int h1 = img1.getHeight();
           int h2 = img2.getHeight();

	      if ((w1!=w2)||(h1!=h2))
	      {
		         System.out.println("Both images should have same dimwnsions");
	      }
	      else
	      {
	         long diff = 0;
	         for (int j = 0; j < h1; j++)
	         {
	            for (int i = 0; i < w1; i++)
	            {
	               //Getting the RGB values of a pixel
	               int pixel1 = img1.getRGB(i, j);

	               Color color1 = new Color(pixel1, true);

	               int r1 = color1.getRed();
	               int g1 = color1.getGreen();
	               int b1 = color1.getBlue();

	               int pixel2 = img2.getRGB(i, j);

	               Color color2 = new Color(pixel2, true);

	               int r2 = color2.getRed();
	               int g2 = color2.getGreen();
	               int b2= color2.getBlue();
	               //sum of differences of RGB values of the two images

               long data = Math.abs(r1-r2)+Math.abs(g1-g2)+ Math.abs(b1-b2);
               diff = diff+data;
            }
         }

          avg = diff/(w1*h1*3);
          percentage = (avg/255)*100;

         System.out.println(n[k]+" "+(k+1)+" Difference: "+(float)percentage);

		  if((Math.min(((float)percentage),((float)minper)))!=(float)minper)
		 {
		        flag=true;
		        minper=(float)percentage;
		        filename=n[k];
		  }
        }
      }
      if(flag)
      {
        System.out.println("Min Difference: "+minper);
        System.out.println("Match File: "+filename);
      }
      else
        System.out.println("No Record Found !!!");
      return filename;
   }
 
}