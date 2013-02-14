import org.junit.Test;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class PercolationTests {

    @Test
    public void testBlocked() {
        int size = 10;
        Percolation percolation = new Percolation(size);
        for (int i = 1; i <= size; i++) {
            for (int j = 1; j <= size; j++) {
                assertFalse(percolation.isOpen(i, j));
                assertFalse(percolation.isFull(i, j));
            }
        }
    }

    @Test
    public void testAllOpen() {
        int size = 10;
        Percolation percolation = new Percolation(size);
        for (int i = 1; i <= size; i++) {
            for (int j = 1; j <= size; j++) {
                percolation.open(i, j);
                assertTrue(percolation.isOpen(i, j));
            }
        }
    }

    @Test
    public void testOpen() {
        int size = 10;
        Percolation percolation = new Percolation(size);
        percolation.open(2, 10);
        assertTrue(percolation.isOpen(2, 10));
    }

    @Test
    public void testFull() {
        int size = 10;
        Percolation percolation = new Percolation(size);
        percolation.open(1, 3);
        percolation.open(2, 3);
        percolation.open(3, 3);
        percolation.open(3, 4);
        percolation.open(4, 4);
        percolation.open(4, 5);
        assertTrue(percolation.isFull(4, 5));
    }

    @Test
    public void testInput20IsFull() {
        int size = 20;
        Percolation percolation = new Percolation(size);
        percolation.open(7, 11);
        percolation.open(18, 11);
        percolation.open(12, 5);
        percolation.open(9, 5);
        percolation.open(5, 9);
        percolation.open(1, 1);
        percolation.open(12, 1);
        assertFalse(percolation.isFull(12, 1));
    }

    @Test
    public void testPercolates() {
        int size = 5;
        Percolation percolation = new Percolation(size);
        percolation.open(1, 3);
        percolation.open(2, 3);
        percolation.open(3, 3);
        percolation.open(3, 4);
        percolation.open(4, 4);
        percolation.open(4, 5);
        percolation.open(5, 5);
        assertTrue(percolation.percolates());
    }

    @Test
    public void testBackwash() {
        int size = 5;
        Percolation percolation = new Percolation(size);
        percolation.open(1, 3);
        percolation.open(2, 3);
        percolation.open(3, 3);
        percolation.open(3, 4);
        percolation.open(4, 4);
        percolation.open(4, 5);
        percolation.open(5, 5);
        percolation.open(5, 1);
        assertTrue(percolation.percolates());
        assertFalse(percolation.isFull(5, 1));
    }

    @Test
    public void testPercolatesWithOne() {
        int size = 1;
        Percolation percolation = new Percolation(size);
        assertFalse(percolation.percolates());
        percolation.open(1, 1);
        assertTrue(percolation.percolates());
    }

    @Test
    public void testPercolatesWithTwo() {
        int size = 2;
        Percolation percolation = new Percolation(size);
        assertFalse(percolation.percolates());
        percolation.open(1, 1);
        percolation.open(2, 1);
        assertTrue(percolation.percolates());
    }

    @Test(expected = IndexOutOfBoundsException.class)
    public void testZeroOutOfBounds() {
        int size = 10;
        Percolation percolation = new Percolation(size);
        percolation.isOpen(0, 10);
    }

    @Test(expected = IndexOutOfBoundsException.class)
    public void testOpenOutOfBounds() {
        int size = 10;
        Percolation percolation = new Percolation(size);
        percolation.isOpen(1, 11);
    }

    @Test(expected = IndexOutOfBoundsException.class)
    public void testFullOutOfBounds() {
        int size = 10;
        Percolation percolation = new Percolation(size);
        percolation.isFull(1, 11);
    }
}
