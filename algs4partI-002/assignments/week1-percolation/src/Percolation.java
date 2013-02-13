
public class Percolation {

    private int width;

    private LoggingQuickUnionUF uf;

    private int[][] grid;

    // create N-by-N grid, with all sites blocked
    public Percolation(int N) {
        width = N;

        // + 2 for virtual sites
        uf = new LoggingQuickUnionUF((N * N) + 2);

        // init N*N grid to blocked
        grid = new int[N][N];
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                grid[i][j] = 0;
            }
        }

        // connect top row to virtual top site
        for (int i = 1; i < width + 1; i++) {
            uf.union(i, 0);
        }

        // connect bottom row to virtual bottom site
        for (int i = ((width * width) - width) + 1; i < (width * width) + 1; i++) {
            uf.union(i, (width * width) + 1);
        }

    }

    // open site (row i, column j) if it is not already
    public void open(int i, int j) {

        if (!isOpen(i, j)) {

            // mark as open
            grid[i - 1][j - 1] = 1;

            // array[width * row + col] = value;

            // id of this newly opened site
            int id = ((width * (i - 1)) + j - 1) + 1;

            try {
                // top
                if (isOpen(i - 1, j)) {
                    int top = ((width * (i - 2)) + j - 1) + 1;
                    uf.union(id, top);
                }
            } catch (IndexOutOfBoundsException e) {
                ;
            }

            try {
                // right
                if (isOpen(i, j + 1)) {
                    int right = ((width * (i - 1)) + j + 1) + 1;
                    uf.union(id, right);
                }
            } catch (IndexOutOfBoundsException e) {
                ;
            }

            try {
                // bottom
                if (isOpen(i + 1, j)) {
                    int bottom = ((width * i) + j - 1) + 1;
                    uf.union(id, bottom);
                }
            } catch (IndexOutOfBoundsException e) {
                ;
            }

            try {
                // left
                if (isOpen(i, j - 1)) {
                    int left = ((width * (i - 1)) + j - 2) + 1;
                    uf.union(id, left);
                }
            } catch (IndexOutOfBoundsException e) {
                ;
            }

        }
    }

    // is site (row i, column j) open?
    public boolean isOpen(int i, int j) {
        if (i < 1 || width < i)
            throw new IndexOutOfBoundsException(
                    "Out of bounds: i = " + i + ", width = " + width
            );
        if (j < 1 || width < j)
            throw new IndexOutOfBoundsException(
                    "Out of bounds: j = " + j + ", width = " + width
            );
        return grid[i - 1][j - 1] == 1;
    }

    // is site (row i, column j) full?
    public boolean isFull(int i, int j) {
        if (i < 1 || width < i)
            throw new IndexOutOfBoundsException(
                    "Out of bounds: i = " + i + ", width = " + width
            );

        if (j < 1 || width < j)
            throw new IndexOutOfBoundsException(
                    "Out of bounds: j = " + j + ", width = " + width
            );
        int id = ((width * (i - 1)) + j - 1) + 1;
        return uf.find(id) == 0;
    }

    // does the system percolate?
    public boolean percolates() {
        return uf.find((width * width) + 1) == uf.find(0);
    }

    public void print() {
        uf.print();

        System.out.println();
        for (int i = 0; i < width; i++) {
            for (int j = 0; j < width; j++) {
                System.out.print(grid[i][j] + " ");
            }
            System.out.println();

        }
        System.out.println();
        for (int i = 0; i < width; i++) {
            for (int j = 0; j < width; j++) {
                System.out.print(((i * width) + j) + "\t");
            }
            System.out.println();

        }
        System.out.println();
    }
}