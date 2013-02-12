
public class LoggingQuickUnionUF extends QuickUnionUF {
    @Override
    public int count() {
        int count = super.count();
        System.out.println("Count. Count = " + count + ".");
        return count;
    }

    public LoggingQuickUnionUF(int N) {
        super(N);
    }

    @Override
    public void union(int p, int q) {
        System.out.println("Union. Unioning " + p + " and " + q + ".");
        super.union(p, q);
    }

    @Override
    public int find(int p) {
//        System.out.println("Find. Finding root of " + p);
        int find = super.find(p);
//        System.out.println("Find. Root of " + p + " is " + find + ".");
        return find;
    }

    @Override
    public boolean connected(int p, int q) {
        boolean connected = super.connected(p, q);
        if (connected)
            System.out.println("Connected: " + p + " " + q);
        return connected;
    }
}
