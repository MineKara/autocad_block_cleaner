# AutoCAD Block Cleaner

## 📄 Overview

**AutoCAD Block Cleaner** is a custom AutoLISP routine designed to streamline and optimize AutoCAD drawings (`.dwg` files) by cleaning unnecessary elements from all blocks and nested blocks **without exploding them**.

## 🚀 Key Features

- Deletes:
  - Lines shorter than 1"
  - Polylines shorter than 1"
  - Arcs with arc length less than 1"
  - Circles with a diameter smaller than 1"
  - All splines
  - All hatches
  - All text entities
- Recursively processes all nested blocks
- Preserves block integrity (no explosions)

---

## 🔧 Installation

1. **Download the LISP file:** Clone or download this repository.
   
   ```bash
   git clone https://github.com/your-username/AutoCAD-Block-Cleaner.git
   ```

2. **Load the LISP in AutoCAD:**

   - Open AutoCAD.
   - Type `APPLOAD` in the command line and press Enter.
   - Browse to the downloaded `.lsp` file and load it.

---

## ⚡ Usage

1. After loading the LISP file, type the following command in the AutoCAD command line:

   ```bash
   CLEANBLOCKS
   ```

2. The routine will process all blocks in the current drawing, applying the cleaning rules.

---

## 💡 How It Works

- Iterates through every block definition, including nested ones.
- Checks each entity and removes it based on defined conditions (length, diameter, or entity type).
- Ensures blocks remain intact without any explosion or redefinition beyond necessary cleaning.

---

## 📝 Customization

If you want to adjust thresholds (e.g., line length limit) or include/exclude more entity types, you can:

- Open the `.lsp` file in any text editor.
- Modify the relevant parameters and conditions as per your requirements.

---

## 🏗️ Contributing

Contributions, issues, and feature requests are welcome!

1. Fork the repository.
2. Create a new branch:
   
   ```bash
   git checkout -b feature/YourFeature
   ```

3. Commit your changes:
   
   ```bash
   git commit -m 'Add your feature'
   ```

4. Push to the branch:
   
   ```bash
   git push origin feature/YourFeature
   ```

5. Open a pull request.

---

## 📜 License

This project is licensed under the [MIT License](LICENSE).

---

## 🙌 Acknowledgments

Thanks to the AutoCAD and LISP communities for continuous support and documentation.

---

## 💬 Feedback

Have suggestions or need help? Open an issue or reach out via [GitHub Issues](https://github.com/your-username/AutoCAD-Block-Cleaner/issues).

