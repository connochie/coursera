
import java.lang.reflect.Field;

public class LoggingQuickUnionUF extends WeightedQuickUnionUF {
    public LoggingQuickUnionUF(int N) {
        super(N);
    }

    public void print() {

        Field f = null;
        try {
            f = this.getClass().getSuperclass().getDeclaredField("id");
        } catch (NoSuchFieldException e) {
           //
        }
        f.setAccessible(true);

        try {
            int[] id = (int[]) f.get(this);

            System.out.println("\n0:" + id[0] + "\t");

            for (int i = 1; i < id.length - 1; i++) {
                int i1 = id[i];
                if (i == i1) {
                    System.out.print("\t");

                } else {
                    System.out.print(i  + ":" + i1 + "\t");
                }
                if (((i) % 9) == 0) System.out.println();
            }

            System.out.println("82:"+id[id.length - 1] + "\t");

        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
    }

}
