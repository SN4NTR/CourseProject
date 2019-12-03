package com.company.util;

import java.util.Scanner;

public class Calculation {

    private static final int NUMBER_LENGTH = 4;
    private static final Scanner scanner = new Scanner(System.in);

    public void start() {
        int[] rg1 = new int[NUMBER_LENGTH]; // A
        int[] rg2 = new int[NUMBER_LENGTH]; // B

        System.out.print("\nEnter the 1st number: ");
        enterNumber(rg1);
        System.out.print("\nEnter the 2nd number: ");
        enterNumber(rg2);

        System.out.print("\nNumber 1: ");
        displayNumber(rg1);
        System.out.print("\nNumber 2: ");
        displayNumber(rg2);

        System.out.print("\n\nThe result of multiplication: ");
        multiply(rg1, rg2);
    }

    private void multiply(int[] rg1, int[] rg2) {
        int[] rg3 = new int[NUMBER_LENGTH]; // C
        int[] result = new int[NUMBER_LENGTH * 2]; // result
        int counter = rg1.length;
        int buffer = 0;

        while (counter > 0) {
            if (rg2[NUMBER_LENGTH - 1] == 1) {
                for (int i = rg3.length - 1; i >= 0; i--) {
                    rg3[i] += rg1[i];

                    if (buffer != 0) {
                        rg3[i] += buffer;
                        buffer--;
                    }
                    if (rg3[i] > 1) {
                        buffer++;
                        rg3[i] -= (buffer + 1);
                    }
                }
            }

            int rg3LastElement = rg3[NUMBER_LENGTH - 1];
            for (int i = rg3.length - 1; i > 0; i--) {
                rg3[i] = rg3[i - 1];
            }
            rg3[0] = 0;

            for (int i = rg2.length - 1; i > 0; i--) {
                rg2[i] = rg2[i - 1];
            }
            rg2[0] = rg3LastElement;

            counter--;
        }

        for (int i = 0; i < rg3.length; i++) {
            result[i] = rg3[i];
        }
        for (int i = 0; i < rg2.length; i++) {
            result[i + NUMBER_LENGTH] = rg2[i];
        }


        for (int i = 0; i < result.length; i++) {
            System.out.print(result[i]);
        }
    }

    private void enterNumber(int[] rg) {
        char[] number = scanner.nextLine().toCharArray();

        for (int i = 0; i < number.length; i++) {
            rg[i] = Character.getNumericValue(number[i]);
        }
    }

    private void displayNumber(int[] rg) {
        for (int b : rg) {
            System.out.print(b + " ");
        }
    }
}
