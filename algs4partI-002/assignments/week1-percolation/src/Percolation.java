public class Percolation {

    private int N;
    private WeightedQuickUnionUF uf;
    private WeightedQuickUnionUF uf2;
    private boolean[][] grid;
    private boolean percolates = false;

    // create N-by-N grid, with all sites blocked
    public Percolation(int N) {
        this.N = N;

        // + 1 for virtual top
        uf = new WeightedQuickUnionUF((N * N) + 1);
        uf2 = new WeightedQuickUnionUF((N * N) + 1);

        // init N*N grid to blocked
        grid = new boolean[N][N];
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                grid[i][j] = false;
            }

            // union top row with virtual top
            uf.union(id(1, i + 1), 0);

            // union top row with virtual bottom
            uf2.union(id(N, i + 1), 0);
        }
    }

    // open site (row i, column j) if it is not already
    public void open(int i, int j) {

        int id = id(i, j);
        int above = above(i, j);
        int left = left(i, j);
        int right = right(i, j);
        int below = below(i, j);

        if (i == 1) {
            uf.union(id(i, j), 0);
        }

        if (i == N) {
            uf2.union(id(i, j), 0);
        }

        // if above, below, left, right are open, union with them
        if (isOpen(above(i), j)) {
            uf.union(id, above);
            uf2.union(id, above);
        }

        if (isOpen(below(i), j)) {
            uf.union(id, below);
            uf2.union(id, below);
        }

        if (isOpen(i, above(j))) {
            uf.union(id, left);
            uf2.union(id, left);
        }

        if (isOpen(i, below(j))) {
            uf.union(id, right);
            uf2.union(id, right);
        }

        // actually open this site
        grid[i - 1][j - 1] = true;

        if (isFull(i, j) && uf2.find(id(i, j)) == uf2.find(0)) {
            percolates = true;
        }

    }

    // is site (row i, column j) open?
    public boolean isOpen(int i, int j) {
        checkIndices(i, j);
        return grid[i - 1][j - 1];
    }

    // is site (row i, column j) full?
    public boolean isFull(int i, int j) {
        checkIndices(i, j);
        return isOpen(i, j) && uf.find(id(i, j)) == uf.find(0);
    }

    // does the system percolate?
    public boolean percolates() {
        return percolates;
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
}