import sys
import os

# Base opcodes
REG_OPS = {
    "add": 0x10,
    "sub": 0x20,
    "xor": 0x30,
    "and": 0x40,
    "or":  0x50,
    "movs":0x70,
    "movd":0x80,
    "movi":0x90,
    "stor": 0xA0,
    "load": 0xB0
}

IMM_OPS = {
    "adi": 0x01,
    "sbi": 0x02,
    "xri": 0x03,
    "ani": 0x04,
    "ori": 0x05,
    "cmi": 0x06
}

SINGLE_OPS = {
    "nop":  0x00,
    "stop": 0x07
}


def parse_register(token):
    token = token.upper()

    if not token.startswith("R"):
        raise ValueError(f"Invalid register '{token}'")

    reg = int(token[1:])

    if reg < 0 or reg > 11:
        raise ValueError(f"Register out of range: {token}")

    return reg


def parse_immediate(token):
    token = token.upper()

    if token.startswith("0X"):
        value = int(token, 16)
    else:
        value = int(token)

    if value < 0 or value > 0xFF:
        raise ValueError(f"Immediate out of range: {token}")

    return value


def assemble(filename):

    output = []

    with open(filename, "r") as f:

        for lineno, line in enumerate(f, start=1):

            # Remove comments
            line = line.split(";")[0]

            # Remove commas
            line = line.replace(",", " ")

            line = line.strip()

            if line == "":
                continue

            parts = line.split()

            inst = parts[0].lower()

            try:

                # nop stop

                if inst in SINGLE_OPS:

                    output.append(SINGLE_OPS[inst])

                # add R1 etc

                elif inst in ["add","sub","xor","and","or","movs","movd","stor","load"]:

                    if len(parts) != 2:
                        raise ValueError("Expected one register")

                    reg = parse_register(parts[1])

                    output.append(REG_OPS[inst] + reg)

                # movi R0,12

                elif inst == "movi":

                    if len(parts) != 3:
                        raise ValueError("Expected register and immediate")

                    reg = parse_register(parts[1])

                    imm = parse_immediate(parts[2])

                    output.append(REG_OPS["movi"] + reg)
                    output.append(imm)

                # adi 05

                elif inst in IMM_OPS:

                    if len(parts) != 2:
                        raise ValueError("Expected immediate")

                    imm = parse_immediate(parts[1])

                    output.append(IMM_OPS[inst])
                    output.append(imm)

                else:

                    raise ValueError(f"Unknown instruction '{inst}'")

            except Exception as e:

                print(f"Line {lineno}: {e}")
                return

    outfile = os.path.splitext(filename)[0] + ".hex"

    with open(outfile, "w") as f:

        for byte in output:

            f.write(f"{byte:02X}\n")

    print(f"Generated {outfile}")


if __name__ == "__main__":

    if len(sys.argv) != 2:
        print("Usage:")
        print("python assembler.py programs/test4.asm")
        sys.exit(1)

    assemble(sys.argv[1])