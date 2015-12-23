import java.io.BufferedInputStream;
import java.util.Scanner;

public class C {

    public static void main(String[] args) {
        final Scanner sc = new Scanner(new BufferedInputStream(System.in));

        /*
            For each character c1 in s1 and c2 in s2,

            case 1) c1 == c2
            Then we can
              a) f(s1,s3) +=1 and f(s2,s3) += 1
              b) f(s1,s3) and f(s2,s3) remain unchanged.

            case 2) c1 != c2
            Then we can
              a) f(s1,s3) += 1
              b) f(s2,s3) += 1
              c) f(s1,s3) +=1 and f(s2,s3) += 1

            Let 'S' be the number of indexes where c1 == c2
            Let 'D' be the number of indexes where c2 != c2

            Let's fix 'ad' that matches case 2)-c). i.e. 0 <= ad <= D  ( ad = all different )
            Then the 'ad' needs to meet the below criteria.
            Condition 1) (D-ad) % 2 == 0. Otherwise, f(s1,s3) != f(s2,s3)

            Condition 2)
            Assuming (D-ad) % 2 == 0, then
            f(s1,s3) = ad + ( (D-ad) / 2 ) + s
            f(s2,s3) = ad + ( (D-ad) / 2 ) + s
            where 0 <= s <= S and s matches case 1)-a)

            Then (ad + ( (D-ad) / 2 )) <= t.
            Otherwise, f(s1,s3) == f(s2,s3) but f(s1,s3) > t

            Condition 3)
            Assuming condition 1) and 2) are satisfied,
            then s = t - ad - ( (D-ad) / 2 )
            then 0 <= s <= S



            1 <= n <= 10^5, which means 1 <= ad <= 10^5.
            We can try every possible value of ad until we find the one that meets the criteria.
         */

        int N = sc.nextInt();
        int t = sc.nextInt();

        String s1 = sc.next();
        String s2 = sc.next();

        boolean[] isSame = new boolean[N];
        int S = 0;
        int D = 0;
        for (int i = 0; i < N; i++) {
            isSame[i] = s1.charAt(i) == s2.charAt(i);
            if (isSame[i]) S++;
            else D++;
        }

        int ad = -1;
        int incBoth = 0;
        for (int pos = 0; ad == -1 && pos <= D; pos++) {
            if ((D - pos) % 2 == 0 && (pos + (D - pos) / 2) <= t) {
                int s = t - pos - ((D - pos) / 2);
                if (s <= S) {
                    ad = pos;
                    incBoth = s;
                }
            }
        }

        if (ad != -1) {
            char[] res = new char[N];
            int s1diff = (D - ad) / 2;
            int s2diff = (D - ad) / 2;
            for (int i = 0; i < N; i++) {
                if (isSame[i]) {
                    if (incBoth > 0) {
                        if (s1.charAt(i) == 'x') res[i] = 'z';
                        else res[i] = 'x';
                        incBoth--;
                    } else {
                        res[i] = s1.charAt(i);
                    }
                } else {
                    if (s1diff > 0) {
                        res[i] = s2.charAt(i);
                        s1diff--;
                    } else if (s2diff > 0) {
                        res[i] = s1.charAt(i);
                        s2diff--;
                    } else if (ad > 0) {
                        // pick something that is different from both
                        for (char ch = 'a'; ch <= 'z'; ch++) {
                            if (s1.charAt(i) != ch && s2.charAt(i) != ch) {
                                res[i] = ch;
                                break;
                            }
                        }
                        ad--;
                    }

                }
            }
            for (int i = 0; i < N; i++)
                System.out.print(res[i]);
            System.out.println();
        } else {
            System.out.println(ad);
        }
    }
}