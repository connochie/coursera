public class Percolation {

    private int N;
    private WeightedQuickUnionUF uf;
    private boolean[][] grid;

    private int BOTTOM;

    // create N-by-N grid, with all sites blocked
    public Percolation(int N) {
        this.N = N;
        this.BOTTOM = (N * N) + 1;

        // + 2 for virtual sites
        uf = new WeightedQuickUnionUF((N * N) + 2);

        // init N*N grid to blocked
        grid = new boolean[N][N];
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                grid[i][j] = false;
            }
        }
    }

    // open site (row i, column j) if it is not already
    public void open(int i, int j) {


        int id = id(i, j);
//        System.out.println("opening " + id);
        int above = above(i, j);
        int left = left(i, j);
        int right = right(i, j);
        int below = below(i, j);

        // for each open bottom row site b
        // if find(b) == left, right or below
        // union b with virtual bottom

        for (int k = 0; k < N; k++) {
            // if open
            if (grid[N - 1][k]) {

                int b = id(N, k);
                int rootOfB = uf.find(b);

                if (rootOfB == left || rootOfB == right || rootOfB == below) {
                    uf.union(b, BOTTOM);
                }
            }
        }


        // if above, below, left, right are open, union with them
        if (isOpen(above(i), j)) {
            uf.union(id, above);
        }

        if (isOpen(below(i), j)) {
            uf.union(id, below);
        }

        if (isOpen(i, above(j))) {
            uf.union(id, left);
        }

        if (isOpen(i, below(j))) {
            uf.union(id, right);
        }


        // if this is a top row site, union with virtual top site
        if (id <= N) {
            uf.union(0, id);
        }


        // if this is a bottom row site
        // if above is full, also union this with virtual bottom
        if (bottomRow(id) && isFull(above(i), j)) {
            uf.union(id, BOTTOM);
        }


        // actually open this site
        grid[i - 1][j - 1] = true;
    }

    private boolean bottomRow(int id) {
        return id < BOTTOM && id > (N * N) - N - 1;
    }

    // is site (row i, column j) open?
    public boolean isOpen(int i, int j) {
        checkIndices(i, j);
        return grid[i - 1][j - 1];
    }

    // is site (row i, column j) full?
    public boolean isFull(int i, int j) {
        checkIndices(i, j);
        return uf.find(id(i, j)) == uf.find(0);
    }

    // does the system percolate?
    public boolean percolates() {
        return uf.find(BOTTOM) == uf.find(0);
    }

    private int id(int i, int j) {
        return (N * (i - 1)) + j;
    }

    private int above(int i, int j) {
        // return the site above if it's valid
        // or the passed site
        return id(above(i), j);
    }

    private int above(int i) {
        // or left, actually
        return i == 1 ? 1 : i - 1;
    }

    private int below(int i, int j) {
        return id(below(i), j);
    }

    private int below(int i) {
        // or right
        return i == N ? N : i + 1;
    }

    private int left(int i, int j) {
        return id(i, above(j));
    }

    private int right(int i, int j) {
        return id(i, below(j));
    }

    private void checkIndices(int i, int j) {
        if (i < 1 || N < i)
            throw new IndexOutOfBoundsException(
                    "Out of bounds: i = " + i + ", N = " + N
            );
        if (j < 1 || N < j)
            throw new IndexOutOfBoundsException(
                    "Out of bounds: j = " + j + ", N = " + N
            );
    }

//    public void print() {
//        uf.print();
//
//        System.out.println();
//        for (int i = 0; i < N; i++) {
//            for (int j = 0; j < N; j++) {
//                System.out.print((grid[i][j] ? 1 : 0) + " ");
//            }
//            System.out.println();
//
//        }
//        System.out.println();
//        for (int i = 0; i < N; i++) {
//            for (int j = 1; j < N + 1; j++) {
//                System.out.print(((i * N) + j) + "\t");
//            }
//            System.out.println();
//
//        }
//        System.out.println("--------------------------");
//    }
}